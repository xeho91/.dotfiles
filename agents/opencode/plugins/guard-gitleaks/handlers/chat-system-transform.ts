import { Hooks } from "@opencode-ai/plugin";

import type { OpenCodeClient } from "../client.ts";
import { log } from "../log.ts";
import { scan } from "../scanner.ts";

export { handle_chat_system_transform };

type HandleChatSystemTransformDeps = {
	client: OpenCodeClient;
};
function handle_chat_system_transform(
	deps: HandleChatSystemTransformDeps,
): NonNullable<Hooks["experimental.chat.system.transform"]> {
	return async (input, output) => {
		await log({ client: deps.client })({
			level: "debug",
			message: "Scanning chat system",
			extra: {
				system_count: output.system.length,
				input,
			},
		});
		output.system = await scan({
			client: deps.client,
			payload: output.system,
			source: "chat.system",
		});
	};
}
