return {
	{
		-- https://github.com/vuki656/package-info.nvim
		"vuki656/package-info.nvim",
		dependencies = {
			{ "MunifTanjim/nui.nvim" },
		},
		event = "BufEnter package.json",
		opts = function(_)
			require("package-info").setup()
		end,
	},
}
