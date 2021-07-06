local autocmd = require("utils").autocmd

-- https://github.com/karb94/neoscroll.nvim
require("neoscroll").setup(
    {
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = {
            "<C-u>",
            "<C-d>",
            "<C-b>",
            -- "<C-f>",
            "<C-y>",
            "<C-e>",
            "zt",
            "zz",
            "zb",
        },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
    }
)

-- https://github.com/Xuyuanp/scrollbar.nvim
autocmd(
    "ScrollbarInit", {
        "CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()",
        "WinEnter,FocusGained * silent! lua require('scrollbar').show()",
        "WinLeave,FocusLost * silent! lua require('scrollbar').clear()",
    }, true
)
vim.g.scrollbar_shape = { head = "▎", body = "▎", tail = "▎" }
