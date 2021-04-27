-- https://github.com/nvim-telescope/telescope.nvim

local map = require("utils").map

-- Mappings
local m_opts = {silent = false, noremap = false}

map("n", "<C-b>", "<cmd>Telescope buffers show_all_buffers=true sort_lastused=true<CR>", m_opts)
map("n", "<C-p>", "<cmd>Telescope file_browser theme=get_dropdown previewer=false<CR>", m_opts)
map("n", "<C-g>", "<cmd>Telescope git_files<CR>", m_opts)
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", m_opts)
map("n", "<C-q>", "<cmd>Telescope frecency<CR>", m_opts)
