-- https://github.com/hrsh7th/nvim-compe

local map = require("utils").map

vim.cmd("set shortmess+=c")
vim.o.completeopt = "menuone,noselect"

require("compe").setup {
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = "enable",
	throttle_time = 80,
	source_timeout = 200,
	incomplete_delay = 400,
	max_abbr_width = 100,
	max_kind_width = 100,
	max_menu_width = 100,
	documentation = true,
	source = {
		buffer = true,
		path = true,
		tags = true,
		spell = true,
		calc = true,
		omni = false, -- It has side effects
		-- Neovim specific
		nvim_lsp = true,
		nvim_lua = true,
		-- External
		treesitter = true,
		-- luasnip = true,
		vsnip = true,
		-- tabnine = true
	}
}

-- Mappings
local m_opts = {silent = true, expr = true, noremap = false}

-- Open completion list
map("i", "<C-Space>", "compe#complete()", m_opts)
-- Confirm selection
-- map("i", "<CR>", "compe#confirm('<CR>')", map_opts)
-- Close completion
map("i", "<C-c>", "compe#close('<C-c>')", m_opts)
-- NOTE: This scrolls the documentation part only
map("i", "<C-u>", "compe#scroll({ 'delta': +4 })", m_opts)
map("i", "<C-d>", "compe#scroll({ 'delta': -4 })", m_opts)
