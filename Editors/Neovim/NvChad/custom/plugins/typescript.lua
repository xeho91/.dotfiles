local nvchad_on_attach = require("plugins.configs.lspconfig").on_attach

local present, typescript = pcall(require, "typescript")

if not present then
	return
end

typescript.setup {
	debug = true,
	disable_commands = false,
	enable_import_on_completion = false,
	go_to_source_definition = {
		fallback = true,
	},
	import_on_completion_timeout = 5000,

	-- ESLint
	eslint_bin = "eslint_d",
	eslint_enable_diagnostics = true,
	eslint_fix_current = true,
	eslint_enable_disable_comments = true,

	-- inlay hints
	auto_inlay_hints = false,
	inlay_hints_highlight = "BufferLineInfo",

	server = {
		on_attach = nvchad_on_attach,
	}
}
