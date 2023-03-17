-- https://github.com/lukas-reineke/indent-blankline.nvim

vim.opt.list = false
vim.opt.listchars:append "eol:↴"
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#320B0E gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#33250A gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guibg=#1C2A13 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guibg=#102A2D gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guibg=#062138 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guibg=#280C31 gui=nocombine]]

local M = {}

M.char = ""
M.char_highlight_list = {
	"IndentBlanklineIndent1",
	"IndentBlanklineIndent2",
	"IndentBlanklineIndent3",
	"IndentBlanklineIndent4",
	"IndentBlanklineIndent5",
	"IndentBlanklineIndent6",
}
M.space_char_highlight_list = {
	"IndentBlanklineIndent1",
	"IndentBlanklineIndent2",
	"IndentBlanklineIndent3",
	"IndentBlanklineIndent4",
	"IndentBlanklineIndent5",
	"IndentBlanklineIndent6",
}
M.show_trailing_blankline_indent = true
M.show_end_of_line = true

return M
