-- https://github.com/glepnir/dashboard-nvim

local g = vim.g
local vimp = require("vimp")
local utils = require("utils")
local autocmd = utils.autocmd

-- Settings
g.dashboard_default_executive = "telescope"

g.dashboard_custom_shortcut = {
	new_file = "<leader>dn",
	find_file = "<leader>df",
	find_word = "<leader>dw",
	find_history = "<leader>dh",
	book_marks = "<leader>db",
	change_colorscheme = "<leader>dc",
	last_session = "<leader>dl"
}

g.dashboard_custom_shortcut_icon = {
	new_file = " ",
	find_file = " ",
	find_word = " ",
	find_history = " ",
	book_marks = " ",
	change_colorscheme = " ",
	last_session = "菱"
}

--[[ g.dashboard_custom_header = {
	"                                                                                                         ....",
	"                                                                                     . ....            ..:lc..",
	"                           .........               ...'''..                    ...,;,...,:;'..        ..:dxxxc.",
	"           .......       ...;loooo:'....,;,..     ..;odddo;..                 ..,ldxo;..;oxdl'.      ..:oxxxd:.",
	"    .......';cll:'..  ....';:::::c:'...cdxdl,..  ..;dxxxxxc.....','............;dxxo;',:oxxxo'.     ..,oxxxxl'",
	"  .,::,'.'codddxdc'...''''............,oxxxd:.....'lxddxxd;....:odddc'....';'..:dxdlcclodxxo;..   ..',ldxxxo,.",
	"  .,oxdocclloddl;...,col:::ccc:'..  ..cdxxxd:,'...;dxddxxc'..,lddxdl,..  ..,,...,clodoodddo;..  ..,coodxxxl,.",
	"  ..;oxxdoodoc;....,oxxxxxxxxxxo:....'lxxxxddoolc:lddddxo;..,lddddc'..   ..,.......';loodo;..  .':dxxxxxdo;.",
	"   .'cdxxxdoc'.. ..:dxxoloolcc::;....;dxxxxxxxdc;:ododxxl'..cddxxl'..    .,,..   ..';:ldo;..   .:dxxxxxxxl,",
	"  ..';ldxxxd:... ..,oxdl;::ccccc::,..:dxxxdol:,..:doodxd;...cxdxxl'..  .....     ..:clll,..    ..,codxxxd:.",
	" ...,:looodxoc,.....:dxdodddxxxxxxd:':dxxxo,....'ldloxxo'...:dxxxl,........     .':cool,..      ...,cdxxo,.",
	"..';looo;',;:cc;...;lodooolc:::::;;'.'codd:.....,locodo:.....;oxxdollll:.      ..;:ldo,..      ..';coxxxdl:.",
	".':odxo;..........;cc;,'..........  ....,;..  ..;o:coc'..   ...,;:ccc:,..      .,;:lo;..      .'lddxxxxdl:,.",
	".'cddxl'.        ......                        .::.,;...       ........       .';:lo;..        .,:looc;'..",
	"..,ldd;..                                      .;'...                        .':cld:..          .......",
	" ...''..                                       .,.                          ..:lodc'",
	"                                               ...                          .,lodo,.",
	"                                                                            .;oddc.",
	"                                                                            .,lo:.",
	"                                                                            ..,,."
} ]]

g.dashboard_custom_footer = {
	"With ♥ for TUI and Neovim from xeho91"
}

-- Disable Tabs (on top)
autocmd(
	"Dashboard_HideStatusline",
	{
		"FileType dashboard set showtabline=0",
		"WinLeave <buffer> set showtabline=2"
	},
	false
)

-- Mappings
vimp.nnoremap("<Leader>ss", "<cmd><C-u>SessionSave<CR>")
vimp.nnoremap("<Leader>sl", "<cmd><C-u>SessionLoad<CR>")
vimp.nnoremap(g.dashboard_custom_shortcut.new_file, "<cmd>DashboardNewFile<CR>")
vimp.nnoremap(g.dashboard_custom_shortcut.find_file, "<cmd>DashboardFindFile<CR>")
vimp.nnoremap(g.dashboard_custom_shortcut.find_word, "<cmd>DashboardFindWord<CR>")
vimp.nnoremap(g.dashboard_custom_shortcut.find_history, "<cmd>DashboardFindHistory<CR>")
vimp.nnoremap(g.dashboard_custom_shortcut.book_marks, "<cmd>DashboardJumpMark<CR>")
vimp.nnoremap(g.dashboard_custom_shortcut.change_colorscheme, "<cmd>DashboardChangeColorscheme<CR>")

-- g.dashboard_preview_command = "cat"
-- g.dashboard_preview_pipeline = "lolcat"
-- g.dashboard_preview_file = "xeho91-logo.txt"
-- g.dashboard_preview_file_height = 100
-- g.dashboard_preview_file_width = 120
