-- https://github.com/folke/neoconf.nvim
--[[ require("neoconf").setup { ]]
--[[ 	-- name of the local settings files ]]
--[[ 	local_settings = ".neoconf.json", ]]
--[[ 	-- name of the global settings file in your Neovim config directory ]]
--[[ 	global_settings = "neoconf.json", ]]
--[[ 	-- import existing settinsg from other plugins ]]
--[[ 	import = { ]]
--[[ 		vscode = true, -- local .vscode/settings.json ]]
--[[ 		coc = true, -- global/local coc-settings.json ]]
--[[ 		nlsp = true, -- global/local nlsp-settings.nvim json settings ]]
--[[ 	}, ]]
--[[ 	-- send new configuration to lsp clients when changing json settings ]]
--[[ 	live_reload = true, ]]
--[[ 	-- set the filetype to jsonc for settings files, so you can use comments ]]
--[[ 	-- make sure you have the jsonc treesitter parser installed! ]]
--[[ 	filetype_jsonc = true, ]]
--[[ 	plugins = { ]]
--[[ 		-- configures lsp clients with settings in the following order: ]]
--[[ 		-- - lua settings passed in lspconfig setup ]]
--[[ 		-- - global json settings ]]
--[[ 		-- - local json settings ]]
--[[ 		lspconfig = { ]]
--[[ 			enabled = true, ]]
--[[ 		}, ]]
--[[ 		-- configures jsonls to get completion in .nvim.settings.json files ]]
--[[ 		jsonls = { ]]
--[[ 			enabled = true, ]]
--[[ 			-- only show completion in json settings for configured lsp servers ]]
--[[ 			configured_servers_only = true, ]]
--[[ 		}, ]]
--[[ 		-- configures lua_ls to get completion of lspconfig server settings ]]
--[[ 		lua_ls = { ]]
--[[ 			-- by default, lua_ls annotations are only enabled in your neovim config directory ]]
--[[ 			enabled_for_neovim_config = true, ]]
--[[ 			-- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file ]]
--[[ 			enabled = false, ]]
--[[ 		}, ]]
--[[ 	}, ]]
--[[ } ]]

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
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}

-- Tailwind CSS
lspconfig.tailwindcss.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
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
	flags = default_flags,
	on_attach = default_attach,
}

-- SQL
lspconfig.sqlls.setup {
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
