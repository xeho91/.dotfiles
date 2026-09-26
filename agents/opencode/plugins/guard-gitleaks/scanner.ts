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

async function scan<T extends ScanPayload>(args: ScanArgs & { payload: T }): Promise<ScanResult<T>> {
	const logger = log({ client: args.client });
	const text = typeof args.payload === "string" ? args.payload : JSON.stringify(args.payload);
	const result = await run_gitleaks({ chunk: text });

	await logger({
		level: "debug",
		message: "Gitleaks scan completed",
		extra: {
			source: args.source,
			exit_code: result.exit_code,
			payload_type: typeof args.payload,
			payload_bytes: Buffer.byteLength(text),
		},
	});

	if (result.exit_code === 0) {
		return args.payload as ScanResult<T>;
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

		let redacted_text = text;
		for (const finding of findings) {
			if (!finding.Secret || !redacted_text.includes(finding.Secret)) {
				await logger({
					level: "error",
					message: "Finding could not be safely redacted",
					extra: { source: args.source, finding: JSON.stringify(finding) },
				});
				throw new Error("Blocked model request: Gitleaks found a secret that could not be safely redacted");
			}
			redacted_text = redacted_text.replaceAll(finding.Secret, redact_text());
		}

		if (typeof args.payload === "string") {
			return redacted_text as ScanResult<T>;
		}

		const parsed = v.safeParse(v.array(v.string()), JSON.parse(redacted_text));
		if (!parsed.success) {
			throw new Error("Blocked model request: Redacted payload could not be parsed");
		}
		return parsed.output as ScanResult<T>;
	}

	await logger({
		level: "error",
		message: `Gitleaks exited with code ${result.exit_code}`,
		extra: { source: args.source, stderr: result.stderr },
	});
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
