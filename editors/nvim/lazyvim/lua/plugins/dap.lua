return {
	{
		-- https://github.com/mfussenegger/nvim-dap
		"mfussenegger/nvim-dap",
		opts = {},
	},
	{
		-- https://github.com/rcarriga/nvim-dap-ui
		"rcarriga/nvim-dap-ui",
		opts = {},
	},
	{
		-- https://github.com/theHamsta/nvim-dap-virtual-text
		"theHamsta/nvim-dap-virtual-text",
		opts = {},
	},
	{
		-- https://github.com/folke/which-key.nvim
		"folke/which-key.nvim",
		opts = {
			defaults = {
				["<leader>d"] = { name = "+debug" },
				["<leader>da"] = { name = "+adapters" },
			},
		},
	},
	{
		-- https://github.com/jay-babu/mason-nvim-dap.nvim
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			-- Makes a best effort to setup the various debuggers with
			-- reasonable debug configurations
			automatic_installation = true,

			-- You can provide additional configuration to the handlers,
			-- see mason-nvim-dap README for more information
			handlers = {},

			-- You'll need to check that you have the required things installed
			-- online, please don't ask me how to install them :)
			ensure_installed = {
				-- Update this to ensure that you have the debuggers for the langs you want
			},
		},
	},
}
