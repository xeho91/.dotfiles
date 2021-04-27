-- https://github.com/L3MON4D3/LuaSnip

local map = require("utils").map

local m_opts = {expr = true, noremap = false, silent = true}

-- Expand or jump
map("i", "<C-l>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-l>'", m_opts)

