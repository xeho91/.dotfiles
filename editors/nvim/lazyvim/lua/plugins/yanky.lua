return {
	{
		-- https://github.com/kkharji/sqlite.lua
		"kkharji/sqlite.lua",
		opts = nil,
	},
	{
		-- https://github.com/gbprod/yanky.nvim
		"gbprod/yanky.nvim",
		opts = function()
			local mapping = require("yanky.telescope.mapping")
			local mappings = mapping.get_defaults()
			mappings.i["<c-p>"] = nil
			return {
				highlight = { timer = 200 },
				ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
				picker = {
					telescope = {
						use_default_mappings = false,
						mappings = mappings,
					},
				},
			}
		end,
	},
}
