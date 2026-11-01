import type { Plugin } from "@opencode-ai/plugin";

export type { OpenCodeClient };

type OpenCodeClient = Parameters<Plugin>[0]["client"];
