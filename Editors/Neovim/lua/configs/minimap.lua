-- https://github.com/wfxr/minimap.vim

local g = vim.g
local vimp = require("vimp")

vimp.nmap("<F8>", "<cmd>MinimapToggle<CR>")

g.minimap_auto_start = 1
g.minimap_auto_start_win_enter = 1
g.minimap_width = 10
g.minimap_highlight = "Title"
g.minimap_base_highlight = "Normal"
g.minimap_block_filetypes = {"fugitive", "nerdtree", "tagbar"}
g.minimap_block_buftypes = {
	"nofile",
	"nowrite",
	"quickfix",
	"terminal",
	"prompt"
}
g.minimap_close_filetypes = {"startify", "netrw"}
g.minimap_close_buftypes = {}
g.minimap_left = 0
g.minimap_highlight_range = 1
