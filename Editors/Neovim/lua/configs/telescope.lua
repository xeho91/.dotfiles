-- https://github.com/nvim-telescope/telescope.nvim

local telescope = require("telescope")
local get_icon = require("icons").get_icon

telescope.setup {
	defaults = {
		layout_strategy = "flex",
		scroll_strategy = "cycle",
		winblend = 15,
		selection_caret = get_icon("caret_right"),
		layout_defaults = {
			horizontal = {
				mirror = false
			},
			vertical = {
				mirror = true
			},
		}
	},
	extensions = {
		frecency = {
			show_scores = false,
			show_unindexed = true,
			ignore_patterns = {"*.git/*", "*/tmp/*"},
			workspaces = {
				["config"] = "/home/xeho91/.config",
				["data"] = "/home/xeho91/.local/share",
				["Project"] = "/home/xeho91/Projects",
				["Dotfiles"] = "/home/xeho91/.dotfiles"
			}
		}
	}
}

telescope.load_extension("frecency")
