-- https://github.com/jose-elias-alvarez/null-ls.nvim
local ok, null_ls = pcall(require, "null-ls")

if not ok then
	return
end

local b = null_ls.builtins

local sources = {
	-- Miscelaneous
	b.formatting.prettierd.with({
		filetypes = {
			"html",
			"json",
			"markdown",
			"css",
			"scss",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"mdx",
			"markdown",
			"yaml",
		},
	}),

	-- CSS & Sass & Less
	b.diagnostics.stylelint,

	-- JavaScript & TypeScript
	b.diagnostics.eslint.with({
		command = "eslint_d",
		filetypes = {
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
			"svelte",
			"vue",
			"mdx",
		},
	}),

	-- JSON
	b.formatting.fixjson.with({ filetypes = { "jsonc" } }),

	-- Markdown
	b.diagnostics.markdownlint,
	-- nls.builtins.code_actions.gitsigns,

	-- Lua
	b.formatting.stylua,
	b.diagnostics.luacheck.with({ extra_args = { "--global vim" } }),

	-- Shell (Bash)
	b.formatting.shfmt,
	b.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

	-- TOML
	b.formatting.taplo,

	b.diagnostics.yamllint,

	-- SQL
	b.diagnostics.sqlfluff,

	-- Other
	-- b.formatting.codespell,
}

return {
	setup = function(on_attach)
		null_ls.setup({
			debug = true,
			sources = sources,
			debounce = 500,
			on_attach = on_attach,
			save_after_format = false,
		})
	end,
}
