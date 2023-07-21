-- https://github.com/jose-elias-alvarez/null-ls.nvim
local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {
	-- Miscelaneous
	b.formatting.prettierd.with {
		filetypes = {
			"md",
			"markdown",
			"html",
			"json",
			"mdx",
			"css",
			"scss",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"yaml",
		},
	},

	-- CSS & Sass & Less
	--[[ b.diagnostics.stylelint, ]]

	-- JavaScript & TypeScript
	b.diagnostics.eslint.with {
		command = "eslint_d",
		filetypes = {
			"javascript",
			"javascriptreact",
			"mdx",
			"typescript",
			"typescriptreact",
			"svelte",
			"vue",
		},
	},

	-- JSON
	--[[ b.formatting.fixjson.with { filetypes = { "jsonc" } }, ]]

	-- Markdown
	b.diagnostics.markdownlint.with {
		filetypes = { "markdown", "markdown.mdx", "md", "mdx" },
	},

	-- nls.builtins.code_actions.gitsigns,

	-- Lua
	b.formatting.stylua,
	b.diagnostics.luacheck.with { extra_args = { "--read-globals vim" } },

	-- Shell (Bash)
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

	-- Rust
	b.formatting.rustfmt,
	--[[ b.formatting.rustfmt.with { ]]
 --[[        extra_args = { "--edition 2021" } ]]
 --[[    }, ]]

	-- SQL
	b.diagnostics.sqlfluff,

	-- TOML
	b.formatting.taplo,

	-- YAML
	--[[ b.diagnostics.yamllint, ]]

	require "typescript.extensions.null-ls.code-actions",
}

null_ls.setup {
	debug = true,
	sources = sources,
	debounce = 500,
	save_after_format = true,
}
