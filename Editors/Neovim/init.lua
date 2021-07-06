local fn = vim.fn
local execute = vim.api.nvim_command
local autocmd = require("utils").autocmd

-- load default options
require("options")

-- Auto install packer.nvim if not exists
local packer_file = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(packer_file)) > 0 then
    execute(
        "!git clone https://github.com/wbthomason/packer.nvim " .. packer_file
    )
end

-- Add packer to Neovim's native package manager
vim.cmd("packadd packer.nvim")
-- Auto compile when there are changes in `plugins.lua` file
autocmd("PackerAutoCompile", "BufWritePost plugins.lua PackerCompile", true)
-- load custom commands
require("commands")
-- Load custom mappings (keybinds)
require("mappings")
-- Install/Load plugins
require("plugins")
