return {
	{
		-- https://github.com/echasnovski/mini.align
		"nvim-mini/mini.align",
		version = "*",
		keys = { "ga", "gA" },
		opts = function()
			require("mini.align").setup()
		end,
	},
}
