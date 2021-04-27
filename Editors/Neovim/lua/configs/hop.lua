-- https://github.com/phaazon/hop.nvim

local map = require("utils").map

require("hop").setup(
	{
		keys = "etovxqpdygfblzhckisuran",
		term_seq_bias = 0.5
	}
)

local m_opts = {noremap = true}

map("n", "$", "<cmd>lua require('hop').hint_words()<CR>", m_opts)
