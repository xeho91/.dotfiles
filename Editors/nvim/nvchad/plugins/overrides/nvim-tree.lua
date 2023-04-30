-- https://github.com/kyazdani42/nvim-tree.lua

local M = {}

M.git = {
	enable = true,
}

M.renderer = {
	highlight_git = true,
	icons = {
		show = {
			git = true,
		},
	},
}

M.view = {
	side = "right",
}

return M
