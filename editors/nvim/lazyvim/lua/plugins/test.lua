return {
	{ "nvim-neotest/neotest-plenary" },
	{
		-- https://github.com/nvim-neotest/neotest
		"nvim-neotest/neotest",
		opts = {
			adapters = {
				["neotest-plenary"] = {},
				["neotest-rust"] = {},
			},
			status = { virtual_text = true },
			output = { open_on_run = true },
			quickfix = {
				open = function()
					if require("lazyvim.util").has("trouble.nvim") then
						vim.cmd("Trouble quickfix")
					else
						vim.cmd("copen")
					end
				end,
			},
		},
	},
	{
		-- https://github.com/rouge8/neotest-rust
		"rouge8/neotest-rust",
		opts = nil,
	},
	{
		"folke/which-key.nvim",
		opts = {
			defaults = {
				["<leader>t"] = { name = "+test" },
			},
		},
	},
}
