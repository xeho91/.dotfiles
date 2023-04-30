-- https://github.com/hrsh7th/nvim-cmp
-- https://nvchad.com/config/plugins#install-remove-plugins--override-them

local M = {}


M.sources = {
    {
        name = "copilot",
        group_index = 2,
        --[[ keyword_length = 2, ]]
    },
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "luasnip" },
    { name = "nvim_lua" },
    { name = "emoji" },
    { name = "buffer" },
    { name = "path" },
    { name = "calc" },
    {
        name = "npm",
        keyword_length = 3,
    },
    { name = "git" },
    -- { name = "neorg" },
}

return M
