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
	},

	-- https://github.com/windwp/nvim-ts-autotag
	autotag = {
		enable = true,
	},

	-- https://github.com/nvim-treesitter/nvim-treesitter-context
	-- context = {
	-- 	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	-- 	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	-- 	trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	-- 	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	-- 	patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
	-- 		-- For all filetypes
	-- 		-- Note that setting an entry here replaces all other patterns for this entry.
	-- 		-- By setting the 'default' entry below, you can control which nodes you want to
	-- 		-- appear in the context window.
	-- 		default = {
	-- 			'class',
	-- 			'function',
	-- 			'method',
	-- 			'for',
	-- 			'while',
	-- 			'if',
	-- 			'switch',
	-- 			'case',
	-- 			'interface',
	-- 			'struct',
	-- 			'enum',
	-- 		},
	-- 		-- Patterns for specific filetypes
	-- 		-- If a pattern is missing, *open a PR* so everyone can benefit.
	-- 		tex = {
	-- 			'chapter',
	-- 			'section',
	-- 			'subsection',
	-- 			'subsubsection',
	-- 		},
	-- 		haskell = {
	-- 			'adt'
	-- 		},
	-- 		rust = {
	-- 			'impl_item',
	--
	-- 		},
	-- 		terraform = {
	-- 			'block',
	-- 			'object_elem',
	-- 			'attribute',
	-- 		},
	-- 		scala = {
	-- 			'object_definition',
	-- 		},
	-- 		vhdl = {
	-- 			'process_statement',
	-- 			'architecture_body',
	-- 			'entity_declaration',
	-- 		},
	-- 		markdown = {
	-- 			'section',
	-- 		},
	-- 		elixir = {
	-- 			'anonymous_function',
	-- 			'arguments',
	-- 			'block',
	-- 			'do_block',
	-- 			'list',
	-- 			'map',
	-- 			'tuple',
	-- 			'quoted_content',
	-- 		},
	-- 		json = {
	-- 			'pair',
	-- 		},
	-- 		typescript = {
	-- 			'export_statement',
	-- 		},
	-- 		yaml = {
	-- 			'block_mapping_pair',
	-- 		},
	-- 	},
	-- 	exact_patterns = {
	-- 		-- Example for a specific filetype with Lua patterns
	-- 		-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
	-- 		-- exactly match "impl_item" only)
	-- 		-- rust = true,
	-- 	},
	--
	-- 	-- [!] The options below are exposed but shouldn't require your attention,
	-- 	--     you can safely ignore them.
	--
	-- 	zindex = 20, -- The Z-index of the context window
	-- 	mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- 	-- Separator between context and content. Should be a single character string, like '-'.
	-- 	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	-- 	separator = nil,
	-- },

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
