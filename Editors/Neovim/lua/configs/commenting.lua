-- https://github.com/b3nj5m1n/kommentary
-- local kommentary = require("kommentary/config")
-- kommentary.configure_language(
--     "default", {
--         prefer_single_line_comments = true,
--         use_consistent_indentation = true,
--         ignore_whitespace = true,
--     }
-- )
-- kommentary.use_extended_mappings()
--
-- https://github.com/terrortylor/nvim-comment
require("nvim_comment").setup(
    {
        -- Linters prefer comment and line to have a space in between markers
        marker_padding = true,
        -- should comment out empty or whitespace only lines
        comment_empty = true,
        -- Should key mappings be created
        create_mappings = true,
        -- Normal mode mapping left hand side
        line_mapping = "gcc",
        -- Visual/Operator mapping left hand side
        operator_mapping = "gc",
    }
)
