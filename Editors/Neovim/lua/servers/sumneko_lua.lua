-- https://github.com/sumneko/lua-language-server

local fn = vim.fn

local config = {
	cmd = {"lua-language-server"},
	settings = {
		Lua = {
			diagnostics = {
				globals = {"vim"}
			},
			runtime = {
				version = "LuaJIT",
				path = vim.split(package.path, ";")
			},
			workspace = {
				library = {
					[fn.expand("$VIMRUNTIME/lua")] = true,
					[fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
				}
			}
		}
	}
}
return config
