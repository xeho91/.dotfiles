return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			opts.servers = vim.tbl_deep_extend("force", opts.servers or {}, {
				harper_ls = {
					filetypes = { "markdown", "text", "tex", "typst" },
					settings = {
						["harper-ls"] = {
							dialect = "American",
							diagnosticSeverity = "hint",
							linters = {
								SpellCheck = true,
								SpelledNumbers = false,
								SentenceCapitalization = true,
								LongSentences = true,
								RepeatedWords = true,
								Spaces = true,
								ExpandAbbreviations = false,
							},
						},
					},
				},

				oxlint = {
					keys = {
						{
							"<leader>xf",
							"<cmd>!oxlint --fix %<cr>",
							desc = "Fix All (oxlint)",
						},
					},
				},

				ts_ls = {
					enabled = false,
				},

				vtsls = {
					enabled = true,

					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},

					settings = {
						vtsls = {
							enableMoveToFileCodeAction = true,
							tsserver = {
								globalPlugins = {},
							},
						},

						typescript = {
							inlayHints = {
								parameterNames = { enabled = "all" },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								enumMemberValues = { enabled = true },
							},
						},
					},
				},
			})

			return opts
		end,
	},
}
