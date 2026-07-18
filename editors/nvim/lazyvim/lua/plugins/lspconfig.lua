return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vtsls = { enabled = false },
				ts_ls = { enabled = true },
			},
		},
	},
}
