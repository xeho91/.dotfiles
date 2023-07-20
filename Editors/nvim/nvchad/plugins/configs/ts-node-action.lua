-- https://github.com/CKolkey/ts-node-action

local tsNodeAction = require "ts-node-action"

tsNodeAction.setup {
	node_actions = {
		["*"] = require "ts-node-action.filetypes.global",
		lua = require "ts-node-action.filetypes.lua",
		json = require "ts-node-action.filetypes.json",
		julia = require "ts-node-action.filetypes.julia",
		yaml = require "ts-node-action.filetypes.yaml",
		ruby = require "ts-node-action.filetypes.ruby",
		eruby = require "ts-node-action.filetypes.ruby",
		python = require "ts-node-action.filetypes.python",
		php = require "ts-node-action.filetypes.php",
		rust = require "ts-node-action.filetypes.rust",
		html = require "ts-node-action.filetypes.html",
		javascript = require "ts-node-action.filetypes.javascript",
		javascriptreact = require "ts-node-action.filetypes.javascript",
		typescript = require "ts-node-action.filetypes.javascript",
		typescriptreact = require "ts-node-action.filetypes.javascript",
		svelte = require "ts-node-action.filetypes.javascript",
		sql = require "ts-node-action.filetypes.sql",
		r = require "ts-node-action.filetypes.r",
	},
}

vim.keymap.set(
	{ "n" },
	"<leader>+",
	tsNodeAction.node_action,
	{ desc = "Trigger Node Action" }
)
