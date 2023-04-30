return {
	setup = function(client)
		-- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
		local ts = require("nvim-lsp-ts-utils")

		client.resolved_capabilities.document_formatting = false
		vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler


		ts.setup({
			disable_commands = false,
			enable_import_on_completion = false,
			import_on_completion_timeout = 5000,

			-- ESLint
			eslint_bin = "eslint_d",
			eslint_enable_diagnostics = true,
			eslint_fix_current = true,
			eslint_enable_disable_comments = true,

			-- inlay hints
			auto_inlay_hints = false,
			inlay_hints_highlight = "BufferLineInfo",
		})

		ts.setup_client(client)
	end,
}
