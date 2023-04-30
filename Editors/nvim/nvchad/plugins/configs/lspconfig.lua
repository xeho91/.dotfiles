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
neodev.setup {
	library = { plugins = { "nvim-dap-ui", "neotest" }, types = true },
}

local util = require "lspconfig.util"
local add_bun_prefix = require("custom.plugins.configs.lsp.bun").add_bun_prefix

util.on_setup = util.add_hook_before(util.on_setup, add_bun_prefix)

--[[ vim.lsp.set_log_level "debug" ]]
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
	filetypes = { "json", "jsonc", "json5" },
	flags = default_flags,
	on_attach = default_attach,
}

-- Lua
lspconfig.lua_ls.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
}

-- Tailwind CSS
lspconfig.tailwindcss.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	root_dir = util.root_pattern(
		"tailwind.config.js",
		"tailwind.config.cjs",
		"tailwind.config.mjs",
		"tailwind.config.ts",
		"tailwind.config.cts",
		"tailwind.config.mts",
		"postcss.config.js",
		"postcss.config.cjs",
		"postcss.config.mjs",
		"postcss.config.ts",
		"postcss.config.cts",
		"postcss.config.mts"
	),
	on_attach = default_attach,
}

-- UnoCSS
lspconfig.unocss.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
}

-- ESLint
lspconfig.eslint.setup {
	capabilities = nvchad_capabilities,
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
	flags = default_flags,
	on_attach = default_attach,
}

-- SQL
lspconfig.sqlls.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
}

lspconfig.svelte.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
}

-- Prisma
lspconfig.prismals.setup {
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
