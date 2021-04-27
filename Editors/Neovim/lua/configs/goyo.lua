-- https://github.com/junegunn/goyo.vim

local g = vim.g
local utils = require("utils")
local map = utils.map
local autocmd = utils.autocmd

print("Hola")
print("Hola")
print("Hola")
print("Hola")
map("n", "<F9>", "<cmd>Goyo<CR>", {noremap = true, expr = false})

g.goyo_width = 83 -- Add signcolumn + scrollbar
g.goyo_height = "80%"

if packer_plugins["limelight.vim"] then
	autocmd(
		"GoyoLimelight",
		{
			[[ User GoyoEnter Limelight ]],
			[[ User GoyoLeave Limelight! ]]
		},
		true
	)
end
