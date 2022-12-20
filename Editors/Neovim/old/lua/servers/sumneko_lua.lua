-- https://github.com/sumneko/lua-language-server
local fn = vim.fn

return {
    cmd = { "lua-language-server" },
    init_options = { documentFormatting = false },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            workspace = {
                library = {
                    [fn.expand("$VIMRUNTIME/lua")] = true,
                    [fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                },
            },
        },
    },
}

