local fn = vim.fn
local execute = vim.api.nvim_command
local cmd = vim.cmd
local utils = require("utils")
local autocmd = utils.autocmd

-- Load default options
require("options")

-- Auto install packer.nvim if not exists
local packer_filePath =
	fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(packer_filePath)) > 0 then
	execute(
		"!git clone https://github.com/wbthomason/packer.nvim " .. packer_filePath
	)
end

cmd [[ packadd packer.nvim ]]

-- -- Auto compile when there are changes in plugins.lua
-- -- cmd [[autocmd BufWritePost plugins.lua PackerCompile]]
-- autocmd("Packer", {[[ BufWritePost plugins.lua PackerCompile ]]}, true)

-- Load custom mappings (keybinds)
require("mappings")

-- Install/Load plugins
require("plugins")
