-- https://nvchad.com/docs/config/mappings

---@type MappingsTable
local M = {}

M.nvimtree = {
	-- mode_opts = { silent = false }, -- this is completely optional
	n = {
		["<leader>ot"] = {
			"<cmd> NvimTreeToggle <CR>",
			"   toggle nvimtree",
		},
	},
}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
	},
}

-- M.telescope = {
-- 	mode_opts = { silent = false }, -- this is completely optional
-- 	n = {
-- 		["<C-n>"] = { "<cmd> Telescope <CR>", "open telescope" }, }, },

M.trouble = {
	-- mode_opts = { noremap = true, silent = false },
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },

		["<leader>xx"] = {
			"<cmd>Trouble<CR>",
			"   LSP Trouble - toggle",
		},

		["<leader>xw"] = {
			"<cmd>Trouble workspace_diagnostics<CR>",
			"   LSP Trouble - diagnostics (workspace)",
		},

		["<leader>xd"] = {
			"<cmd>Trouble document_diagnostics<CR>",
			"   LSP Trouble - diagnostics (document)",
		},

		["<leader>xl"] = {
			"<cmd>Trouble loclist<CR>",
			"   LSP Trouble - loclist",
		},

		["<leader>xq"] = {
			"<cmd>Trouble quickfix<CR>",
			"   LSP Trouble - quickfix",
		},

		["gR"] = {
			"<cmd>Trouble lsp_references<CR>",
			"   LSP Trouble - references",
		},
	},
}

return M
