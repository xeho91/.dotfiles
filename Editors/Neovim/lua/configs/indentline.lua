-- https://github.com/lukas-reineke/indent-blankline.nvim
local g = vim.g

g.indent_blankline_use_treesitter = true
g.indentLine_fileTypeExclude = {
    "startify",
    "packer",
    "help",
    "dashboard",
    "peek",
}
g.indent_blankline_show_first_indent_level = true
g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_current_context = true
g.indent_blankline_context_patterns = {
    "class",
    "function",
    "method",
    "^if",
    "^while",
    "^for",
    "^object",
    "^table",
    "block",
    "arguments",
}

