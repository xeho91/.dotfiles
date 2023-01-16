local nvchad_on_attach = require("plugins.configs.lspconfig").on_attach
local nvchad_capabilities = require("plugins.configs.lspconfig").capabilities

local presentLspconfig, lspconfig = pcall(require, "lspconfig")
local presentNeodev, neodev = pcall(require, "neodev")

if not presentNeodev then
	return
end

if not presentLspconfig then
	return
end

-- https://github.com/folke/neodev.nvim
neodev.setup {}

vim.lsp.set_log_level "debug"

local function default_attach(client, bufnr)
	nvchad_on_attach(client, bufnr)
end

local default_flags = {
	debounce_text_changes = 150,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- CSS & Less & Sass
lspconfig.cssls.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
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
-- lspconfig.codeqlls.setup {
-- 	capabilities = capabilities,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		default_attach(client, bufnr)
-- 	end,
-- }

-- HTML
lspconfig.html.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
}

-- JSON
lspconfig.jsonls.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
}

-- Lua
-- lspconfig.sumneko_lua.setup({
--   settings = {
--     Lua = {
--       completion = {
--         callSnippet = "Replace"
--       }
--     }
--   }
-- })
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
-- lspconfig.tailwindcss.setup {
-- 	capabilities = capabilities,
-- 	flags = {
-- 		debounce_text_changes = 150,
-- 	},
-- 	on_attach = function(client, bufnr)
-- 		default_attach(client, bufnr)
-- 	end,
-- }

lspconfig.eslint.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
}

-- YAML
lspconfig.yamlls.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			},
		},
	},
	on_attach = default_attach,
}
