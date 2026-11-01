import * as v from "valibot";

import type { OpenCodeClient } from "./client.ts";
import { GitleaksFindingSchema } from "./finding.ts";
import { log } from "./log.ts";
import { redact_text } from "./redactor.ts";
import { run_gitleaks } from "./runner.ts";

export { scan };

type ScanPayload = string | string[];
type ScanResult<T extends ScanPayload> = T extends string ? string : string[];
type ScanArgs = {
	client: OpenCodeClient;
	payload: ScanPayload;
	source: string;
};

function create_separator(payload: string[]): string {
	let separator = "\n\n<~GUARD_GITLEAKS_BATCH_BOUNDARY~>\n\n";
	while (payload.some((value) => value.includes(separator))) {
		separator += "~";
	}
	return separator;
}

function redact_findings(text: string, findings: v.InferOutput<typeof GitleaksFindingSchema>[]): string {
	const line_starts = [0];
	for (let index = 0; index < text.length; index += 1) {
		if (text[index] === "\n") {
			line_starts.push(index + 1);
		}
	}

	let match_search_from = 0;
	const ranges = findings.map((finding) => {
		if (
			finding.StartLine === undefined ||
			finding.EndLine === undefined ||
			finding.StartColumn === undefined ||
			finding.EndColumn === undefined
		) {
			throw new Error("Blocked model request: Gitleaks finding has no location");
		}

		const start_line = line_starts[finding.StartLine - 1];
		const end_line = line_starts[finding.EndLine - 1];
		if (start_line === undefined || end_line === undefined) {
			throw new Error("Blocked model request: Gitleaks finding has an invalid location");
		}

		const finding_start = start_line + finding.StartColumn - 1;
		const finding_end = end_line + finding.EndColumn;
		if (finding.Match && finding.Secret) {
			const match_start = text.indexOf(finding.Match, match_search_from);
			const secret_offset = finding.Match.indexOf(finding.Secret);
			if (match_start >= 0 && secret_offset >= 0) {
				match_search_from = match_start + finding.Match.length;
				return {
					start: match_start + secret_offset,
					end: match_start + secret_offset + finding.Secret.length,
				};
			}
		}

		return { start: finding_start, end: finding_end };
	});

	ranges.sort((left, right) => left.start - right.start || left.end - right.end);
	const merged = [] as typeof ranges;
	for (const range of ranges) {
		if (range.start < 0 || range.end > text.length || range.start >= range.end) {
			throw new Error("Blocked model request: Gitleaks finding has an invalid location");
		}
		const previous = merged.at(-1);
		if (previous && range.start <= previous.end) {
			previous.end = Math.max(previous.end, range.end);
			continue;
		}
		merged.push({ ...range });
	}

	let redacted_text = text;
	for (const range of merged.reverse()) {
		redacted_text =
			redacted_text.slice(0, range.start) + redact_text() + redacted_text.slice(range.end);
	}
	return redacted_text;
}

async function scan<TPayload extends ScanPayload>(
	args: ScanArgs & { payload: TPayload },
): Promise<ScanResult<TPayload>> {
	const logger = log({ client: args.client });

	const separator = Array.isArray(args.payload) ? create_separator(args.payload) : undefined;
	const chunk = typeof args.payload === "string" ? args.payload : args.payload.join(separator);
	const started_at = performance.now();
	await logger({
		level: "debug",
		message: "Gitleaks scan started",
		extra: {
			source: args.source,
			payload_bytes: Buffer.byteLength(chunk),
			payload_items: Array.isArray(args.payload) ? args.payload.length : 1,
		},
	});
	const result = await run_gitleaks({ chunk });
	await logger({
		level: "debug",
		message: "Gitleaks scan completed",
		extra: {
			source: args.source,
			exit_code: result.exit_code,
			duration_ms: Math.round(performance.now() - started_at),
		},
	});
	if (result.exit_code === 0) {
		return args.payload as ScanResult<TPayload>;
	}

	let findings: v.InferOutput<typeof GitleaksFindingSchema>[];
	try {
		const parsed = JSON.parse(result.stdout);
		const validated = v.safeParse(v.array(GitleaksFindingSchema), parsed);
		if (!validated.success) {
			throw new Error("Invalid Gitleaks output");
		}
		findings = validated.output;
	} catch {
		findings = [];
	}

	if (findings.length > 0) {
		await logger({
			level: "warn",
			message: "Redacting detected secrets",
			extra: {
				source: args.source,
				finding_count: findings.length,
				rule_ids: findings.map((finding) => finding.RuleID).filter(Boolean),
			},
		});

		const redacted_text = redact_findings(chunk, findings);

		if (typeof args.payload === "string") {
			return redacted_text;
		}

		if (separator === undefined) {
			throw new Error("Blocked model request: Redacted payload could not be parsed");
		}
		const parsed = redacted_text.split(separator);
		if (parsed.length !== args.payload.length) {
			throw new Error("Blocked model request: Redacted payload could not be parsed");
		}
		return parsed as ScanResult<TPayload>;
	}

	throw new Error(
		`Blocked model request: Gitleaks failed with exit code ${result.exit_code}${
			result.stderr.trim() ? `: ${result.stderr.trim()}` : ""
		}`,
		{
			cause: {
				stderr: result.stderr.trim(),
				stdout: result.stdout.trim(),
			},
		},
	);
}
