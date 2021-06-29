-- https://github.com/theia-ide/typescript-language-server
local root_pattern = require("lspconfig/util").root_pattern

return {
    init_options = { documentFormatting = false },
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
    },
    root_dir = root_pattern("tsconfig.json", "jsconfig.json"),
    handlers = { ["textDocument/formatting"] = false },
}
