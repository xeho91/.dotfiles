-- https://github.com/nvim-telescope/telescope.nvim
local telescope = require("telescope")
local get_icon = require("icons").get_icon
local vimp = require("vimp")

-- Mappings
local m_opts = { silent = false, noremap = false }

vimp.nmap(
    "<C-b>",
    "<cmd>Telescope buffers show_all_buffers=true sort_lastused=true<CR>"
)
vimp.nmap(
    "<C-p>", "<cmd>Telescope find_files theme=get_dropdown previewer=false<CR>"
)
vimp.nmap("<C-g>", "<cmd>Telescope git_files<CR>")
vimp.nmap("<C-f>", "<cmd>Telescope live_grep<CR>")
vimp.nmap("<C-q>", "<cmd>Telescope frecency<CR>")

telescope.setup {
    defaults = {
        layout_strategy = "flex",
        scroll_strategy = "cycle",
        winblend = 15,
        selection_caret = get_icon("caret_right"),
        layout_defaults = {
            horizontal = { mirror = false },
            vertical = { mirror = true },
        },
    },
    extensions = {
        frecency = {
            show_scores = false,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
            workspaces = {
                ["config"] = "/home/xeho91/.config",
                ["data"] = "/home/xeho91/.local/share",
                ["Project"] = "/home/xeho91/Projects",
                ["Dotfiles"] = "/home/xeho91/.dotfiles",
            },
        },
    },
}

telescope.load_extension("frecency")
