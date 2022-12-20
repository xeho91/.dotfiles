-- https://github.com/folke/lua-dev.nvim
local lspconfig = require("lspconfig")
local luadev = require("lua-dev").setup()

lspconfig.sumneko_lua.setup(luadev)
