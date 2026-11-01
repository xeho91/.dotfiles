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
	return async (_input, output) => {
		await log({ client: deps.client })({
			level: "debug",
			message: "chat.messages.transform invoked",
			extra: {
				message_count: output.messages.length,
				part_count: output.messages.reduce((count, message) => count + message.parts.length, 0),
			},
		});
		const targets: Array<{
			value: string;
			apply: (value: string) => void;
		}> = [];

		for (const msg of output.messages) {
			for (const part of msg.parts) {
				if ((part.type === "text" || part.type === "reasoning") && part.text !== undefined) {
					targets.push({
						value: part.text,
						apply: (value) => {
							part.text = value;
						},
					});
					continue;
				}

				if (part.type === "tool" && part.state.status === "completed") {
					if (typeof part.state.output === "string") {
						targets.push({
							value: part.state.output,
							apply: (value) => {
								part.state.output = value;
							},
						});
						continue;
					}

					part.state.output = await scan({
						client: deps.client,
						payload: part.state.output,
						source: "chat.messages.tool",
					});
				}
			}
		}

		if (targets.length > 0) {
			const scanned = await scan({
				client: deps.client,
				payload: targets.map((target) => target.value),
				source: "chat.messages.batch",
			});
			for (const [index, target] of targets.entries()) {
				target.apply(scanned[index]);
			}
		}
	};
}
