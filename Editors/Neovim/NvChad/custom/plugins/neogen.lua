-- https://github.com/danymat/neogen
require("neogen").setup({
	enabled = true,
	input_after_comment = true,
	languages = {
		typescriptreact = require("neogen.configurations.typescript"),
		javascriptreact = require("neogen.configurations.javascript"),
	},
})

vim.api.nvim_set_keymap(
	"n",
	"<Leader>df",
	":lua require('neogen').generate()<CR>",
	{ noremap = true, silent = true }
)
