-- https://github.com/phaazon/hop.nvim

local vimp = require("vimp")

require("hop").setup({
	keys = "etovxqpdygfblzhckisuran",
	term_seq_bias = 0.5
})

vimp.nnoremap("$", "<cmd>lua require('hop').hint_words()<CR>")
