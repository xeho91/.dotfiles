import { Hooks } from "@opencode-ai/plugin";

import type { OpenCodeClient } from "../client.ts";
import { log } from "../log.ts";
import { scan } from "../scanner.ts";

export { handle_tool_execute_after };

type HandleToolExecuteAfter = {
	client: OpenCodeClient;
};
function handle_tool_execute_after(
	deps: HandleToolExecuteAfter,
): NonNullable<Hooks["tool.execute.after"]> {
	return async (input, output) => {
		await log({ client: deps.client })({
			level: "debug",
			message: "Scanning tool output",
			extra: {
				input,
				output,
			},
		});
		output.output = await scan({
			client: deps.client,
			payload: output.output,
			source: "tool.execute.after",
		});
	};
}
