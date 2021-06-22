-- https://github.com/vscode-langservers/vscode-css-languageserver-bin
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
    capabilities = capabilities,
    cmd = { "vscode-css-language-server", "--stdio" },
    filetypes = { "css", "pcss", "scss", "less" },
    settings = {
        css = { validate = false },
        pcss = { validate = true },
        less = { validate = true },
        scss = { validate = true },
    },
}

