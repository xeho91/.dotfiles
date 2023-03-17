---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

-- M.options require "custom.options"

M.ui = {
	cmp = {
		border_color = "blue",
		icons = true,
		lspkind_text = true,
		selected_item_bg = "colored",
		style = "atom_colored",
	},
	hl_override = highlights.override,
	hl_add = highlights.add,

	theme = "tokyonight",
	theme_toggle = { "onedark", "one_light" },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
