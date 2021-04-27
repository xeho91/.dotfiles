-- https://github.com/hrsh7th/vim-vsnip

local map = require("utils").map

local m_opts = {expr = true, noremap = false}

-- Expand or jump
map("i", "<C-j>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", m_opts)
map("s", "<C-j>", "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'", m_opts)

-- -- Jump forward
map("i", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", m_opts)
map("s", "<Tab>", "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'", m_opts)

-- Jump backwards
map("i", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", m_opts)
map("s", "<S-Tab>", "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", m_opts)
