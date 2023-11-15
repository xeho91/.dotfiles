return {
	{
		-- https://github.com/smoka7/multicursors.nvim
		"smoka7/multicursors.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"smoka7/hydra.nvim",
		},
		opts = function()
			local N = require("multicursors.normal_mode")
			local I = require("multicursors.insert_mode")
			return {
				normal_keys = {
					-- to change default lhs of key mapping change the key
					[","] = {
						-- assigning nil to method exits from multi cursor mode
						method = N.clear_others,
						-- you can pass :map-arguments here
						opts = { desc = "Clear others" },
					},
				},
				insert_keys = {
					-- to change default lhs of key mapping change the key
					["<CR>"] = {
						-- assigning nil to method exits from multi cursor mode
						method = I.Cr_method,
						-- you can pass :map-arguments here
						opts = { desc = "New line" },
					},
				},
			}
		end,
		cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
		keys = {
			{
				mode = { "v", "n" },
				"<Leader>m",
				"<cmd>MCstart<cr>",
				desc = "Create a selection for selcted text or word under the cursor",
			},
		},
	},
	-- {
	-- 	-- https://github.com/mg979/vim-visual-multi
	-- 	"mg979/vim-visual-multi",
	-- 	event = "VeryLazy",
	-- },
}
