import child_process from "node:child_process";
import stream_consumers from "node:stream/consumers";

export { run_gitleaks };
export type { RunGitleaksResult };

type RunGitleaksResult = {
	stdout: string;
	stderr: string;
	exit_code: number;
};
type RunGitleaksArgs = {
	chunk: string;
};
async function run_gitleaks(args: RunGitleaksArgs): Promise<RunGitleaksResult> {
	const child_proc = child_process.spawn(
		"gitleaks",
		["stdin", "--report-format", "json", "--report-path", "-", "--no-banner", "--no-color"],
		{
			stdio: ["pipe", "pipe", "pipe"],
		},
	);

	const stdout_promise = stream_consumers.text(child_proc.stdout);
	const stderr_promise = stream_consumers.text(child_proc.stderr);
	child_proc.stdin.end(args.chunk);

	const [stdout, stderr, exit_code] = await Promise.all([
		stdout_promise,
		stderr_promise,
		new Promise<number>((resolve, reject) => {
			child_proc.once("error", reject);
			child_proc.once("close", (code) => resolve(code ?? 1));
		}),
	]);

	return {
		stdout,
		stderr,
		exit_code,
	};
}
