return {
	{
		-- https://github.com/sQVe/sort.nvim
		"sQVe/sort.nvim",
		cmd = { "Sort" },
		config = function()
			require("sort").setup({})
		end,
	},
}
