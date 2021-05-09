-- https://github.com/folke/tokyonight.nvim
local g = vim.g

g.tokyonight_style = "storm"

g.tokyonight_terminal_colors = true

g.tokyonight_italic_comments = true
g.tokyonight_italic_keywords = true
g.tokyonight_italic_functions = true
g.tokyonight_italic_variables = true

g.tokyonight_transparent = false

g.tokyonight_hide_inactive_statusline = true

g.tokyonight_sidebars = { "help", "qf", "terminal", "packer" }
g.tokyonight_dark_sidebar = true
g.tokyonight_dark_float = true

vim.cmd("colorscheme tokyonight")

