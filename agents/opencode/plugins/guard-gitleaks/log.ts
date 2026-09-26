import type { OpenCodeClient } from "./client.ts";
import { PLUGIN_NAME } from "./constants.ts";

export { log };

type LogDeps = {
	client: OpenCodeClient;
};
type LogArgs = Omit<
	NonNullable<NonNullable<Parameters<OpenCodeClient["app"]["log"]>[0]>["body"]>,
	"service"
>;
function log(deps: LogDeps) {
	return (args: LogArgs) =>
		deps.client.app.log({
			body: {
				...args,
				service: PLUGIN_NAME,
			},
		});
}
