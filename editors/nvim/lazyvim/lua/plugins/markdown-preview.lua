return {
	{
		"iamcco/markdown-preview.nvim",
		enabled = false,
	},
	{
		"selimacerbas/markdown-preview.nvim",
		name = "markdown-preview-selimacerbas",
		cmd = { "MarkdownPreview", "MarkdownPreviewRefresh", "MarkdownPreviewStop" },
		dependencies = { "selimacerbas/live-server.nvim" },
		ft = { "markdown" },
		keys = {
			{
				"<leader>cp",
				"<cmd>MarkdownPreview<cr>",
				ft = "markdown",
				desc = "Markdown Preview",
			},
		},
		config = function()
			require("markdown_preview").setup()
		end,
	},
}
