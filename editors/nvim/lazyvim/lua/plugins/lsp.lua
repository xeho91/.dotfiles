return {
	-- add symbols-outline
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		opts = {
			-- add your options that should be passed to the setup() function here
			position = "right",
		},
	},
	-- {
	-- 	-- https://github.com/folke/neodev.nvim
	-- 	"folke/neodev.nvim",
	-- 	opts = {},
	-- },
}
