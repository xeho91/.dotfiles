-- https://github.com/lukas-reineke/indent-blankline.nvim

vim.opt.list = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "nbsp:+"
vim.opt.listchars:append "tab:  "
vim.opt.listchars:append "trail:-"
vim.opt.listchars:append "eol:↴"
vim.opt.termguicolors = true

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

local M = {}

M.char = " "
M.char_highlight_list = {
	"IndentBlanklineIndent1",
	"IndentBlanklineIndent2",
	"IndentBlanklineIndent3",
	"IndentBlanklineIndent4",
	"IndentBlanklineIndent5",
	"IndentBlanklineIndent6",
}
M.space_char_blankline = " "
M.space_char_highlight_list = {
	"IndentBlanklineIndent1",
	"IndentBlanklineIndent2",
	"IndentBlanklineIndent3",
	"IndentBlanklineIndent4",
	"IndentBlanklineIndent5",
	"IndentBlanklineIndent6",
}
--[[ M.show_current_context = true ]]
--[[ M.show_current_context_start = true ]]
M.show_end_of_line = true
M.show_trailing_blankline_indent = true

return M
