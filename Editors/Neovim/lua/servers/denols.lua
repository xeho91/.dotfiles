-- https://github.com/denoland/deno
local root_pattern = require("lspconfig/util").root_pattern

return {
    -- cmd = { "deno", "lsp" },
    filetypes = { "javascript", "typescript" },
    init_options = { enable = true, lint = true, unstable = true },
    root_dir = root_pattern("mod.ts", "import_map.json"),
}
