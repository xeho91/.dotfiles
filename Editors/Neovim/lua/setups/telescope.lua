-- https://github.com/nvim-telescope/telescope.nvim

local vimp = require("vimp")

-- Mappings
local m_opts = {silent = false, noremap = false}

vimp.nmap("<C-b>", "<cmd>Telescope buffers show_all_buffers=true sort_lastused=true<CR>")
vimp.nmap("<C-p>", "<cmd>Telescope find_files theme=get_dropdown previewer=false<CR>")
vimp.nmap("<C-g>", "<cmd>Telescope git_files<CR>")
vimp.nmap("<C-f>", "<cmd>Telescope live_grep<CR>")
vimp.nmap("<C-q>", "<cmd>Telescope frecency<CR>")
