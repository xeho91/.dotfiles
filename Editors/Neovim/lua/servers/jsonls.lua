-- https://github.com/vscode-langservers/vscode-json-languageserver
return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json" },
    init_options = { provideFormatter = false },
}
