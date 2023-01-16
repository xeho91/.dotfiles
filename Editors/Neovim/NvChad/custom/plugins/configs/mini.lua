-- https://github.com/echasnovski/mini.nvim

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-align.md
require("mini.align").setup()

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-cursorword.md
require("mini.cursorword").setup {
	-- Delay (in ms) between when cursor moved and when highlighting appeared
	delay = 100,
}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-indentscope.md
require("mini.indentscope").setup {
	draw = {
		-- Delay (in ms) between event and start of drawing scope indicator
		delay = 100,

		-- Animation rule for scope's first drawing. A function which, given next
		-- and total step numbers, returns wait time (in ms). See
		-- |MiniIndentscope.gen_animation()| for builtin options. To not use
		-- animation, supply `require('mini.indentscope').gen_animation('none')`.
		-- animation = --<function: implements constant 20ms between steps>,
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Textobjects
		object_scope = "ii",
		object_scope_with_border = "ai",

		-- Motions (jump to respective border line; if not present - body line)
		goto_top = "[i",
		goto_bottom = "]i",
	},

	-- Options which control computation of scope. Buffer local values can be
	-- supplied in buffer variable `vim.b.miniindentscope_options`.
	options = {
		-- Type of scope's border: which line(s) with smaller indent to
		-- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
		border = "both",

		-- Whether to use cursor column when computing reference indent. Useful to
		-- see incremental scopes with horizontal cursor movements.
		indent_at_cursor = true,

		-- Whether to first check input line to be a border of adjacent scope.
		-- Use it if you want to place cursor on function header to get scope of
		-- its body.
		try_as_border = false,
	},

	-- Which character to use for drawing scope indicator
	symbol = "╎",
}

-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-move.md
require("mini.move").setup()

-- https://github.com/echasnovski/mini.nvim#minisurround
require("mini.surround").setup {
	-- Number of lines within which surrounding is searched
	n_lines = 20,

	-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
	highlight_duration = 500,

	-- Mappings. Use `''` (empty string) to disable one.
	mappings = {
		add = "<leader>ra", -- Add surrounding
		delete = "<leader>rd", -- Delete surrounding
		find = "<leader>rf", -- Find surrounding (to the right)
		find_left = "<leader>rF", -- Find surrounding (to the left)
		highlight = "<leader>rh", -- Highlight surrounding
		replace = "<leader>rr", -- Replace surrounding
		update_n_lines = "<leader>rl", -- Update `n_lines`
	},
}
