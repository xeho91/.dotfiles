import type { Hooks } from "@opencode-ai/plugin";

import type { OpenCodeClient } from "../client.ts";
import { log } from "../log.ts";
import { scan } from "../scanner.ts";

export { handle_chat_messages_transform };

type HandleChatMessagesTransformDeps = {
	client: OpenCodeClient;
};
function handle_chat_messages_transform(
	deps: HandleChatMessagesTransformDeps,
): NonNullable<Hooks["experimental.chat.messages.transform"]> {
	return async (input, output) => {
		await log({ client: deps.client })({
			level: "debug",
			message: "Scanning chat messages",
			extra: {
				message_count: output.messages.length,
				input,
			},
		});
		for (const msg of output.messages) {
			for (const part of msg.parts) {
				if ((part.type === "text" || part.type === "reasoning") && part.text !== undefined) {
					part.text = await scan({
						client: deps.client,
						payload: part.text,
						source: `chat.messages.${part.type}`,
					});
					continue;
				}

				if (part.type === "tool" && part.state.status === "completed") {
					part.state.output = await scan({
						client: deps.client,
						payload: part.state.output,
						source: "chat.messages.tool",
					});
				}
			}
		}
	};
}
