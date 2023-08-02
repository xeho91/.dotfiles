return {
	{
		-- https://github.com/echasnovski/mini.align
		"echasnovski/mini.align",
		version = "*",
		keys = { "ga", "gA" },
		opts = function()
			require("mini.align").setup()
		end,
	},
}
