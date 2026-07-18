-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 100
vim.opt.wrap = false
vim.opt.colorcolumn = "110"

vim.opt.autoread = true
vim.opt.confirm = true

vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_eslint_auto_format = true

vim.g.lazyvim_explorer = false
vim.g.lazyvim_picker = false
