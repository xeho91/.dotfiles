local nvchad_on_attach = require("plugins.configs.lspconfig").on_attach
local nvchad_capabilities = require("plugins.configs.lspconfig").capabilities

local presentLspconfig, lspconfig = pcall(require, "lspconfig")
--[[ local presentNeodev, neodev = pcall(require, "neodev") ]]

--[[ if not presentNeodev then ]]
--[[ 	return ]]
--[[ end ]]

if not presentLspconfig then
	return
end

-- https://github.com/folke/neodev.nvim
--[[ neodev.setup { ]]
--[[ 	library = { plugins = { "nvim-dap-ui", "neotest" }, types = true }, ]]
--[[ } ]]

local util = require "lspconfig.util"
--[[ local add_bun_prefix = require("custom.plugins.configs.lsp.bun").add_bun_prefix ]]

--[[ util.on_setup = util.add_hook_before(util.on_setup, add_bun_prefix) ]]

--[[ vim.lsp.set_log_level "debug" ]]
local function default_attach(client, bufnr)
	nvchad_on_attach(client, bufnr)
	require("lsp-inlayhints").on_attach(client, bufnr)
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

--[[ lspconfig.cssmodules_ls.setup { ]]
--[[ 	capabilities = nvchad_capabilities, ]]
--[[ 	flags = default_flags, ]]
--[[ 	on_attach = default_attach, ]]
--[[ } ]]

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
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

-- Tailwind CSS
--[[ lspconfig.tailwindcss.setup { ]]
--[[ 	capabilities = nvchad_capabilities, ]]
--[[ 	flags = default_flags, ]]
--[[ 	root_dir = util.root_pattern( ]]
--[[ 		"tailwind.config.js", ]]
--[[ 		"tailwind.config.cjs", ]]
--[[ 		"tailwind.config.mjs", ]]
--[[ 		"tailwind.config.ts", ]]
--[[ 		"tailwind.config.cts", ]]
--[[ 		"tailwind.config.mts", ]]
--[[ 		"postcss.config.js", ]]
--[[ 		"postcss.config.cjs", ]]
--[[ 		"postcss.config.mjs", ]]
--[[ 		"postcss.config.ts", ]]
--[[ 		"postcss.config.cts", ]]
--[[ 		"postcss.config.mts" ]]
--[[ 	), ]]
--[[ 	on_attach = default_attach, ]]
--[[ } ]]

-- UnoCSS
--[[ lspconfig.unocss.setup { ]]
--[[ 	capabilities = nvchad_capabilities, ]]
--[[ 	flags = default_flags, ]]
--[[ 	on_attach = default_attach, ]]
--[[ } ]]

-- ESLint
lspconfig.eslint.setup {
	capabilities = nvchad_capabilities,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
	},
	flags = default_flags,
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
		default_attach(client, bufnr)
	end,
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
--[[ lspconfig.prismals.setup { ]]
--[[ 	capabilities = nvchad_capabilities, ]]
--[[ 	flags = default_flags, ]]
--[[ 	on_attach = default_attach, ]]
--[[ } ]]

-- Rust
lspconfig.rust_analyzer.setup {
	capabilities = nvchad_capabilities,
	flags = default_flags,
	on_attach = default_attach,
	settings = {
		["rust-analyzer"] = {
			diagnostics = {
				enable = true,
			},
		},
	},
}
--[[ require("rust-tools").setup { server = { on_attach = default_attach } } ]]

-- TOML
lspconfig.taplo.setup {
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

--[[ vim.api.nvim_create_augroup("LspAttach_inlayhints", {}) ]]
--[[ vim.api.nvim_create_autocmd("LspAttach", { ]]
--[[ 	group = "LspAttach_inlayhints", ]]
--[[ 	callback = function(args) ]]
--[[ 		if not (args.data and args.data.client_id) then ]]
--[[ 			return ]]
--[[ 		end ]]
--[[]]
--[[ 		local bufnr = args.buf ]]
--[[ 		local client = vim.lsp.get_client_by_id(args.data.client_id) ]]
--[[ 		require("lsp-inlayhints").on_attach(client, bufnr) ]]
--[[ 	end, ]]
--[[ }) ]]

local present, typescript = pcall(require, "typescript")

if not present then
	return
end

typescript.setup {
	debug = false,
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
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"svelte",
		},
		--[[ cmd = { ]]
		--[[ 	"bun", ]]
		--[[ 	"run", ]]
		--[[ 	"/Users/xeho91/.local/share/nvim/mason/bin/typescript-language-server", ]]
		--[[ 	"--stdio", ]]
		--[[ }, ]]
	},
}
