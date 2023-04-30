-- https://github.com/CKolkey/ts-node-action

local tsNodeAction = require "ts-node-action"

tsNodeAction.setup()

vim.keymap.set(
	{ "n" },
	"<leader>+",
	tsNodeAction.node_action,
	{ desc = "Trigger Node Action" }
)
