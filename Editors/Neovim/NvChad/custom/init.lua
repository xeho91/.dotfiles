-- FIXME: This causes a lot of issues
-- vim.wo.colorcolumn = "80"
vim.o.emoji = false
vim.o.wrap = false

-- Folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 2
-- vim.o.foldnestmax = 3
-- vim.o.foldminlines = 50

vim.o.ruler = true
vim.o.tabstop = 4
vim.o.smartindent = false
vim.o.shiftwidth = 4
vim.o.relativenumber = true
