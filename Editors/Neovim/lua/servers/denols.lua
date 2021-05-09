-- https://github.com/denoland/deno
return {
    cmd = { "deno", "lsp" },
    filetypes = { "javascript", "typescript" },
    handlers = {},
    init_options = {
        documentFormatting = false,
        fmt = false,
        enable = true,
        lint = true,
        unstable = true,
    },
}
