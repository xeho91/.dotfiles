-- https://github.com/windwp/nvim-autopairs
local fn = vim.fn
local map = require("utils").map
local npairs = require("nvim-autopairs")

npairs.setup(
    {
        disable_filetype = { "TelescopePrompt" },
        ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
        enable_moveright = true,
        check_ts = false,
    }
)

_G.MUtils = {}

vim.g.completion_confirm_key = ""

MUtils.completion_confirm = function()
    if fn.pumvisible() ~= 0 then
        if fn.complete_info()["selected"] ~= -1 then
            return fn["compe#confirm"](npairs.esc("<CR>"))
        else
            return npairs.esc("<CR>")
        end
    else
        return npairs.autopairs_cr()
    end
end

local m_opts = { noremap = true, expr = true }

map("i", "<CR>", "v:lua.MUtils.completion_confirm()", m_opts)

