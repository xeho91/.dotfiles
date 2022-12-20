local lspconfig = require("lspconfig")
local ts = require("typescript")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

require("neodev").setup({
    -- https://github.com/folke/neodev.nvim#-setup
    -- add any options here, or leave empty to use the default settings
})

local function default_attach(client, bufnr)
	on_attach(client, bufnr)
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- CSS & Less & Sass
lspconfig.cssls.setup {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client, bufnr)
		default_attach(client, bufnr)
	end,
	settings = {
		css = {
			validate = false,
		},
		less = {
			validate = false,
		},
		scss = {
			validate = false,
		},
	},
	single_file_support = true,
}

-- CodeQL analysis
lspconfig.codeqlls.setup {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client, bufnr)
		default_attach(client, bufnr)
	end,
}

-- HTML
lspconfig.html.setup {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client, bufnr)
		default_attach(client, bufnr)
	end,
}

-- JSON
lspconfig.jsonls.setup {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client, bufnr)
		default_attach(client, bufnr)
	end,
}

-- Lua
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})
-- lspconfig.sumneko_lua.setup(require("neodev").setup {
-- 	lspconfig = {
-- 		cmd = { "lua-language-server" },
-- 		flags = {
-- 			debounce_text_changes = 150,
-- 		},
-- 		on_attach = function(client, bufnr)
-- 			default_attach(client, bufnr)
-- 		end,
-- 	},
-- })

-- Tailwind CSS
lspconfig.tailwindcss.setup {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},
	on_attach = function(client, bufnr)
		default_attach(client, bufnr)
	end,
}

-- TypeScript
lspconfig.tsserver.setup {
	-- filetypes = {
	-- 	"javascript",
	-- 	"javascriptreact",
	-- 	"typescript",
	-- 	"typescriptreact",
	-- 	"mdx",
	-- 	"svelte",
	-- 	"vue",
	-- },

	init_options = require("typescript").init_options,

	on_attach = function(client, bufnr)
		default_attach(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		vim.lsp.handlers["textDocument/codeAction"] = ts.code_action_handler

		ts.setup {
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
		}

		ts.setup_client(client)
	end,
}

-- YAML
lspconfig.yamlls.setup {
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 150,
	},

	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			},
		},
	},
	on_attach = function(client, bufnr)
		default_attach(client, bufnr)
	end,
}
