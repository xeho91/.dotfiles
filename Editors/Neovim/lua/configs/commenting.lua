-- https://github.com/terrortylor/nvim-comment
require("nvim_comment").setup {
    marker_padding = true, -- Linters prefer comment and line to have a space in between markers
    comment_empty = true, -- should comment out empty or whitespace only lines
    create_mappings = true, -- Should key mappings be created
    line_mapping = "gcc", -- Normal mode mapping left hand side
    operator_mapping = "gc", -- Visual/Operator mapping left hand side
}
