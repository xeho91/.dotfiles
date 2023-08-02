return {
	-- {
	-- 	-- https://github.com/smoka7/multicursors.nvim
	-- 	"smoka7/multicursors.nvim",
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"smoka7/hydra.nvim",
	-- 	},
	-- 	opts = function()
	-- 		local N = require("multicursors.normal_mode")
	-- 		local I = require("multicursors.insert_mode")
	-- 		return {
	-- 			normal_keys = {
	-- 				-- to change default lhs of key mapping change the key
	-- 				["b"] = {
	-- 					-- assigning nil to method exits from multi cursor mode
	-- 					method = N.clear_others,
	-- 					-- description to show in hint window
	-- 					desc = "Clear others",
	-- 				},
	-- 			},
	-- 			insert_keys = {
	-- 				-- to change default lhs of key mapping change the key
	-- 				["<CR>"] = {
	-- 					-- assigning nil to method exits from multi cursor mode
	-- 					method = I.CR_method,
	-- 					-- description to show in hint window
	-- 					desc = "New line",
	-- 				},
	-- 			},
	-- 		}
	-- 	end,
	-- 	keys = {
	-- 		{
	-- 			"<Leader>m",
	-- 			"<cmd>MCstart<cr>",
	-- 			desc = "Create a selection for word under the cursor",
	-- 		},
	-- 	},
	-- },
	{
		-- https://github.com/mg979/vim-visual-multi
		"mg979/vim-visual-multi",
		event = "VeryLazy",
	},
}
