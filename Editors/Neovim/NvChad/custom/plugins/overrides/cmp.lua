-- https://github.com/hrsh7th/nvim-cmp
-- https://nvchad.com/config/plugins#install-remove-plugins--override-them

return {
	sources = {
		{ name = "copilot", group_index = 2, keyword_length = 2 },
		{ name = "treesitter" },
		{ name = "emoji" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "calc" },
		{ name = "npm", keyword_length = 3 },
		-- { name = "neorg" },
	},
}
