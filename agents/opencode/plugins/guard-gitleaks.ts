import type { Plugin } from "@opencode-ai/plugin";

// import { log } from "./guard-gitleaks/log.ts";
// import { handle_chat_messages_transform } from "./guard-gitleaks/handlers/chat-messages-transform.ts";
// import { handle_chat_system_transform } from "./guard-gitleaks/handlers/chat-system-transform.ts";
// import { handle_tool_execute_after } from "./guard-gitleaks/handlers/tool-execute-after.ts";

const plugin: Plugin = async (input, _opts) => {
	// await log({ client: input.client })({
	// 	level: "debug",
	// 	message: "Plugin initialized",
	// });

	return {};
	// return {
	// 	"experimental.chat.messages.transform": handle_chat_messages_transform({
	// 		client: input.client,
	// 	}),
	// 	"experimental.chat.system.transform": handle_chat_system_transform({ client: input.client }),
	// 	"tool.execute.after": handle_tool_execute_after({ client: input.client }),
	// };
};

export default plugin;
