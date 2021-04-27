-- https://github.com/nvim-treesitter/nvim-treesitter
local opt = require("utils").opt

local window = {vim.o, vim.wo}

-- Folding
opt("foldmethod", "expr", window) -- Enable folding method based on indent
opt("foldexpr", "nvim_treesitter#foldexpr()", window)

require("nvim-treesitter.configs").setup {
	ensure_installed = "maintained",
	-- https://github.com/nvim-treesitter/nvim-treesitter#highlight
	highlight = {
		enable = true,
		use_languagetree = true
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter#incremental-selection
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_innremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm"
		}
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter#indentation
	indent = {
		enable = true
	},
	-- https://github.com/andymass/vim-matchup
	matchup = {
		enable = true
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter-refactor
	refactor = {
		smart_rename = {
			enable = true,
			keymaps = {smart_rename = "grr"}
		},
		highlight_definitions = {enable = true},
		highlight_current_scope = {enable = true},
		navigation = {enable = true}
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	textobjects = {
		-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-select
		select = {
			enable = true,
			keymaps = {
				["iF"] = {
					python = "(function_definition) @function",
					cpp = "(function_definition) @function",
					c = "(function_definition) @function",
					java = "(method_declaration) @function"
				},
				-- or you use the queries from supported languages with textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ac"] = "@conditional.outer",
				["ic"] = "@conditional.inner",
				["ae"] = "@block.outer",
				["ie"] = "@block.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["is"] = "@statement.inner",
				["as"] = "@statement.outer",
				["ad"] = "@comment.outer",
				["am"] = "@call.outer",
				["im"] = "@call.inner"
			}
		},
		-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-swap
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner"
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner"
			}
		},
		-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#text-objects-move
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer"
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer"
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer"
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer"
			}
		},
		-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects#textobjects-lsp-interop
		lsp_interop = {
			enable = true,
			peek_definition_code = {
				["df"] = "@function.outer",
				["dF"] = "@class.outer"
			}
		}
	},
	-- https://github.com/p00f/nvim-ts-rainbow
	-- https://github.com/nvim-treesitter/playground
	playground = {
		enable = true,
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
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
			show_help = "?"
		}
	},
	-- https://github.com/nvim-treesitter/playground#query-linter
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = {"BufWrite", "CursorHold"}
	},
	rainbow = {
		enable = true,
		extended_mode = true -- Highlight also non-parentheses delimiters
	},
	-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
	context_commentstring = {
		enable = true
	}
}
