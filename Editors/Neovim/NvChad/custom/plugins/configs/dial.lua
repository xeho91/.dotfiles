-- https://github.com/monaqa/dial.nvim
local present, augend = pcall(require, "dial/augend")

if not present then
	return
end

require("dial.config").augends:register_group {
	default = {
		augend.integer.alias.decimal,
		augend.integer.alias.decimal_int,
		augend.integer.alias.hex,
		augend.integer.alias.octal,
		augend.integer.alias.binary,
		augend.date.alias["%Y/%m/%d"],
		augend.date.alias["%m/%d/%Y"],
		augend.date.alias["%d/%m/%Y"],
		augend.date.alias["%m/%d/%y"],
		augend.date.alias["%d/%m/%y"],
		augend.date.alias["%m/%d"],
		augend.date.alias["%-m/%-d"],
		augend.date.alias["%Y-%m-%d"],
		augend.date.alias["%Y年%-m月%-d日"],
		augend.date.alias["%Y年%-m月%-d日(%ja)"],
		augend.date.alias["%H:%M:%S"],
		augend.date.alias["%H:%M"],
		augend.constant.alias.ja_weekday,
		augend.constant.alias.ja_weekday_full,
		augend.constant.alias.bool,
		augend.constant.alias.alpha,
		augend.constant.alias.Alpha,
		augend.constant.new {
			elements = { "and", "or" },
			word = true,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "enable", "disable" },
			word = true,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "on", "off" },
			word = true,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "info", "warning", "error" },
			word = true,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "INFO", "WARN", "ERROR" },
			word = true,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "Info", "Warn", "Error" },
			word = true,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "TODO", "FIXME" },
			word = true,
			cyclic = true,
		},
		augend.constant.new {
			elements = { "&&", "||" },
			word = false,
			cyclic = true,
		},
		augend.semver.alias.semver,
	},

	typescript = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.constant.new { elements = { "let", "const" } },
	},

	visual = {
		augend.integer.alias.decimal,
		augend.integer.alias.hex,
		augend.date.alias["%Y/%m/%d"],
		augend.constant.alias.alpha,
		augend.constant.alias.Alpha,
	},
}

vim.api.nvim_set_keymap(
	"n",
	"<C-a>",
	"<Plug>(dial-increment)",
	{ noremap = false, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<C-x>",
	"<Plug>(dial-decrement)",
	{ noremap = false, silent = true }
)
vim.api.nvim_set_keymap(
	"v",
	"<C-a>",
	"<Plug>(dial-increment)",
	{ noremap = false, silent = true }
)
vim.api.nvim_set_keymap(
	"v",
	"<C-x>",
	"<Plug>(dial-decrement)",
	{ noremap = false, silent = true }
)
vim.api.nvim_set_keymap(
	"v",
	"g<C-a>",
	"<Plug>(dial-increment-additional)",
	{ noremap = false, silent = true }
)
vim.api.nvim_set_keymap(
	"v",
	"g<C-x>",
	"<Plug>(dial-decrement-additional)",
	{ noremap = false, silent = true }
)
