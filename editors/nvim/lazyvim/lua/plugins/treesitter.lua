return {
	{
		-- https://github.com/nvim-treesitter/nvim-treesitter
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.highlight.enable = true
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "ron", "rust", "toml" })
			end
			opts = {
				highlight = { enable = true },
				indent = { enable = true },
				ensure_installed = {
					"bash",
					"c",
					"html",
					"javascript",
					"json",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vim",
					"vimdoc",
					"yaml",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
						node_decremental = "<bs>",
					},
				},
			}
		end,
	},
	{
		-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		"nvim-treesitter/nvim-treesitter-textobjects",
		opts = nil,
	},
}
