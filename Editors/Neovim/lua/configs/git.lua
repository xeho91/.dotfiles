-- https://github.com/lewis6991/gitsigns.nvim
local get_icon = require("icons").get_icon

require("gitsigns").setup(
    {
        signs = {
            add = {
                hl = "GitSignsAdd",
                text = get_icon("line"),
                numhl = "GitSignsAdd",
                linehl = "GitSignsAdd",
            },
            change = {
                hl = "GitSignsChange",
                text = get_icon("line"),
                numhl = "GitSignsChange",
                linehl = "GitSignsChange",
            },
            delete = {
                hl = "GitSignsDelete",
                text = "▄",
                numhl = "GitSignsDelete",
                linehl = "GitSignsDelete",
            },
            topdelete = {
                hl = "GitSignsDelete",
                text = "▀",
                numhl = "GitSignsDelete",
                linehl = "GitSignsDelete",
            },
            changedelete = {
                hl = "GitSignsChange",
                text = get_icon("line"),
                numhl = "GitSignsChange",
                linehl = "GitSignsChange",
            },
        },
        numhl = true,
        linehl = false,
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,
            ["n ]c"] = {
                expr = true,
                "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
            },
            ["n [c"] = {
                expr = true,
                "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
            },
            ["n <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
            ["n <leader>hu"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
            ["n <leader>hr"] = "<cmd>Gitsigns reset_hunk<CR>",
            ["n <leader>hR"] = "<cmd>Gitsigns reset_buffer<CR>",
            ["n <leader>hp"] = "<cmd>Gitsigns preview_hunk<CR>",
            ["n <leader>hb"] = "<cmd>Gitsigns blame_line<CR>",
            ["n <leader>ht"] = "<cmd>Gitsigns toggle_current_line_blame<CR>",
            -- Text objects
            ["o ih"] = "<cmd><C-u>Gitsigns select_hunk<CR>",
            ["x ih"] = "<cmd><C-u>Gitsigns select_hunk<CR>",
        },
        watch_index = { interval = 1000 },
        current_line_blame = false,
        sign_priority = 6,
        update_debounce = 100,
        -- status_formatter = nil, -- Use default
        use_decoration_api = false,
        use_internal_diff = false, -- If luajit is present
    }
)
