-- https://github.com/neovim/nvim-lspconfig

local fn = vim.fn
local lsp = vim.lsp
local utils = require("utils")
local map = utils.map
local autocmd = utils.autocmd
local get_icon = require("icons").get_icon
local lsp_config = require("lspconfig")
local lsp_status = require("lsp-status")
local lsp_kind = require("lspkind")
local lsp_saga = require("lspsaga")
local lsp_trouble = require("trouble")

local symbols = {
	Text = " ",
	Method = "ƒ ",
	Function = " ",
	Constructor = " ",
	Variable = " ",
	Class = " ",
	Interface = "ﰮ ",
	Module = " ",
	Property = " ",
	Unit = " ",
	Value = " ",
	Enum = "了",
	Keyword = " ",
	Snippet = "﬌ ",
	Color = " ",
	File = " ",
	Folder = "ﱮ ",
	EnumMember = " ",
	Constant = " ",
	Struct = " "
}

-- https://github.com/onsails/lspkind-nvim
lsp_kind.init({with_text = true, symbol_map = symbols})

local sign_define = fn.sign_define

sign_define("LspDiagnosticsSignError", {text = "", numhl = "RedSign"})
sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "YellowSign"})
sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "WhiteSign"})
sign_define("LspDiagnosticsSignHint", {text = "", numhl = "BlueSign"})

-- https://github.com/nvim-lua/lsp-status.nvim
lsp_status.config(
	{
		kind_labels = symbols,
		diagnostics = true,
		indicator_separator = "",
		indicator_errors = get_icon("error"),
		indicator_warnings = get_icon("warning"),
		indicator_info = get_icon("info"),
		indicator_hint = get_icon("hint"),
		indicator_ok = get_icon("success"),
		current_function = true,
		status_symbol = get_icon("diagnostic"),
		select_symbol = function(cursor_pos, symbol)
			if symbol.valueRange then
				local value_range = {
					["start"] = {
						character = 0,
						line = fn.byte2line(symbol.valueRange[1])
					},
					["end"] = {
						character = 0,
						line = fn.byte2line(symbol.valueRange[2])
					}
				}

				return require("lsp-status/util").in_range(cursor_pos, value_range)
			end
		end
	}
)
lsp_status.register_progress()
lsp.handlers["textDocument/publishDiagnostics"] =
	lsp.with(
	lsp.diagnostic.on_publish_diagnostics,
	{
		virtual_text = true,
		signs = true,
		update_in_insert = true,
		underline = true
	}
)

-- https://github.com/glepnir/lspsaga.nvim
lsp_saga.init_lsp_saga(
	{
		use_saga_diagnostic_sign = true,
		error_sign = get_icon("error"),
		warn_sign = get_icon("warning"),
		hint_sign = get_icon("hint"),
		infor_sign = get_icon("info"),
		dianostic_header_icon = get_icon("diagnostic"),
		code_action_icon = get_icon("bulb"),
		code_action_prompt = {
			enable = true,
			sign = true,
			sign_priority = 20,
			virtual_text = true
		},
		finder_definition_icon = get_icon("definition"),
		finder_reference_icon = get_icon("reference"),
		max_preview_lines = 10, -- preview lines of lsp_finder and definition preview
		finder_action_keys = {
			open = "o",
			vsplit = "s",
			split = "i",
			quit = "q",
			scroll_down = "<C-u>",
			scroll_up = "<C-d>" -- quit can be a table
		},
		code_action_keys = {
			quit = "q",
			exec = "<CR>"
		},
		rename_action_keys = {
			quit = "<Esc>",
			exec = "<CR>" -- quit can be a table
		},
		definition_preview_icon = get_icon("preview"),
		border_style = "round",
		rename_prompt_prefix = get_icon("rename") .. "Rename:"
	}
)

local on_attach = function(client, bufnr)
	if lsp_status ~= nil then
		lsp_status.on_attach(client, bufnr)
	end

	require("lsp_signature").on_attach()

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings
	local m_opts = {noremap = true, silent = false}

	-- Definition
	map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", m_opts)
	map("n", "<leader>gd", "<cmd>Lspsaga preview_definition<CR>", m_opts)

	-- Declaration
	map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", m_opts)

	-- References
	map("n", "<leader>sr", "<cmd>lua vim.lsp.buf.references()<CR>", m_opts)
	map(
		"n",
		"<leader>gr",
		"<cmd>Telescope lsp_references theme=get_dropdown previewer=false<CR>",
		m_opts
	)

	-- Implementation
	map("n", "<leader>si", "<cmd>lua vim.lsp.buf.implementation()", m_opts)
	map(
		"n",
		"<leader>gi",
		"<cmd>Telescope lsp_implementations theme=get_dropdown previewer=false<CR>",
		m_opts
	)

	-- Type Definition
	map("n", "<leader>gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", m_opts)

	-- Rename
	map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", m_opts)

	-- Preview Declarations/References - Async Lsp Finder
	map("n", "<leader>ph", "<cmd>Lspsaga lsp_finder<CR>", m_opts)

	-- Code action
	map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", m_opts)
	map("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", m_opts)

	-- Hover doc
	map("n", "<leader>H", "<cmd>Lspsaga hover_doc<CR>", m_opts)
	-- Scroll Hover Doc FIXME: Conflicts with vim-smoothie
	--[[ map("n", "<C-d>", "<cmd>lua require('lspsaga/action').smart_scroll_with_saga(1)<CR>", m_opts)
	map("n", "<C-u>", "<cmd>lua require('lspsaga/action').smart_scroll_with_saga(-1)<CR>", m_opts) ]]
	-- Signature help
	map("n", "<leader>S", "<cmd>Lspsaga signature_help<CR>", m_opts)

	-- Diagnostic
	map("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", m_opts)
	map("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", m_opts)
	map("n", "<leader>D", "<cmd>LspTroubleOpen<CR>", m_opts)

	if client.resolved_capabilities.document_formatting then
		map("n", "<leader>Fl", "<cmd>lua vim.lsp.buf.formatting()<CR>", m_opts)
	end

	if client.resolved_capabilities.document_highlight == true then
		autocmd(
			"LSP_AutoCommands",
			{
				"CursorHold <buffer> lua vim.lsp.buf.document_highlight()",
				"CursorHold <buffer> Lspsaga show_cursor_diagnostics",
				"CursorMoved <buffer> lua vim.lsp.buf.clear_references()"
			},
			false
		)
	end
end

local servers = {
	sumneko_lua = require("servers/sumneko_lua")
}

local snippet_capabilities = {
	textDocument = {
		completion = {
			completionItem = {snippetSupport = true},
			resolveSupport = {
				properties = {
					"documentation",
					"detail",
					"additionalTextEdits"
				}
			}
		}
	}
}

for server, config in pairs(servers) do
	config.on_attach = on_attach
	config.capabilities =
		vim.tbl_deep_extend(
		"keep",
		config.capabilities or {},
		lsp_status.capabilities,
		snippet_capabilities
	)
	lsp_config[server].setup(config)
end

lsp_trouble.setup(
	{
		height = 10, -- height of the trouble list
		icons = true, -- use dev-icons for filenames
		mode = "workspace", -- "workspace" or "document"
		fold_open = "", -- icon used for open folds
		fold_closed = "", -- icon used for closed folds
		action_keys = {
			-- key mappings for actions in the trouble list
			close = "q", -- close the list
			cancel = "<Esc>", -- cancel the preview and get back to your last window / buffer / cursor
			refresh = "r", -- manually refresh
			jump = {"<CR>", "<Tab>"}, -- jump to the diagnostic or open / close folds
			toggle_mode = "m", -- toggle between "workspace" and "document" mode
			toggle_preview = "P", -- toggle auto_preview
			preview = "p", -- preview the diagnostic location
			close_folds = {"zM", "zm"}, -- close all folds
			open_folds = {"zR", "zr"}, -- open all folds
			toggle_fold = {"zA", "za"}, -- toggle fold of current file
			previous = "k", -- preview item
			next = "j" -- next item
		},
		indent_lines = true, -- add an indent guide below the fold icons
		auto_open = false, -- automatically open the list when you have diagnostics
		auto_close = false, -- automatically close the list when you have no diagnostics
		auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
		auto_fold = false, -- automatically fold a file trouble list at creation
		use_lsp_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
	}
)
