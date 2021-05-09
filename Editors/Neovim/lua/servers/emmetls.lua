-- https://github.com/aca/emmet-ls
require("lspconfig/configs").emmet_ls = {
    default_config = {
        cmd = { "emmet-ls", "--stdio" },
        filetypes = { "html", "css", "svelte" },
        root_dir = require("lspconfig").util.root_pattern(
            ".git", vim.fn.getcwd()
        ),
    },
}
return {}

