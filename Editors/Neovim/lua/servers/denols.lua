-- https://github.com/denoland/deno
return {
    cmd = { "deno", "lsp" },
    filetypes = { "javascript", "typescript" },
    init_options = { enable = true, lint = true, unstable = true },
}
