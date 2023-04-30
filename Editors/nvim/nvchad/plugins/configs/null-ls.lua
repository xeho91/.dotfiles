-- https://github.com/jose-elias-alvarez/null-ls.nvim
local ok, null_ls = pcall(require, "null-ls")

if not ok then
	return
end

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
	b.diagnostics.stylelint,

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

	require "typescript.extensions.null-ls.code-actions",

	-- JSON
	b.formatting.fixjson.with { filetypes = { "jsonc" } },

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

	-- TOML
	b.formatting.taplo,

	b.diagnostics.yamllint,

	-- SQL
	b.diagnostics.sqlfluff,

	-- Other
	--[[ b.formatting.codespell, ]]
}

return {
	setup = function(on_attach)
		null_ls.setup {
			debug = true,
			sources = sources,
			debounce = 500,
			on_attach = on_attach,
			save_after_format = false,
		}
	end,
}

-- local sources = {
--
--   -- webdev stuff
--   b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
--   b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes
--
--   -- cpp
--   b.formatting.clang_format,
-- }
