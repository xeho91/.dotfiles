return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = function(_, opts)
			opts.window.position = "right"
			opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
				or { "terminal", "Trouble", "qf", "Outline" }
			table.insert(opts.open_files_do_not_replace_types, "edgy")
		end,
	},
	{
		-- https://github.com/s1n7ax/nvim-window-picker
		"s1n7ax/nvim-window-picker",
	},
}
