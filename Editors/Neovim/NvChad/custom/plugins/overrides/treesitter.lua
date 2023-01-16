-- https://github.com/nvim-treesitter/nvim-treesitter

return {
	ensure_installed = {
		"bash",
		"cmake",
		"comment",
		"css",
		"html",
		"javascript",
		"jsonc",
		"lua",
		"python",
		"regex",
		"svelte",
		"toml",
		"tsx",
		"typescript",
		"vue",
		"yaml",
		"json",
		-- "norg",
		-- "norg_meta",
		-- "norg_table",
	},

	-- https://github.com/windwp/nvim-ts-autotag
	autotag = {
		enable = true,
	},

	-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},

	highlight = { enable = true, use_languagetree = true },

	indent = { enable = true },

	-- https://github.com/p00f/nvim-ts-rainbow
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters
		max_file_lines = 1000,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-n>",
			node_incremental = "<C-n>",
			scope_incremental = "<C-s>",
			node_decremental = "<C-r>",
		},
	},

	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},

	textsubjects = {
		enable = true,
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
		},
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = true, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},

		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},

		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["gD"] = "@function.outer",
			},
		},
	},
}
