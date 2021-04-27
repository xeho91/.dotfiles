local g = vim.g
local map = require("utils").map

-- Map leader
g.mapleader = [[\]]
g.maplocalleader = [[,]]

if g.neovide then
	function ToggleFullScreen()
		if g.neovide_fullscreen then
			return false
		else
			return true
		end
	end

	map("n", "<F11>", '<cmd>let g:neovide_fullscreen = luaeval("ToggleFullScreen()")<CR>', {})
end
