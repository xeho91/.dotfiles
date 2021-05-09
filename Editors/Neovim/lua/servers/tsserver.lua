-- https://github.com/theia-ide/typescript-language-server
return {
    init_options = { documentFormatting = false },
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "javascript", "typescript" },
    rootMarkers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
}
