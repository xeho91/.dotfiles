-- https://github.com/tailwindlabs/tailwindcss-intellisense
local root_pattern = require("lspconfig/util").root_pattern

return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = {
        "aspnetcorerazor",
        "astro",
        "astro-markdown",
        "blade",
        "django-html",
        "edge",
        "eelixir",
        "ejs",
        "erb",
        "eruby",
        "gohtml",
        "haml",
        "handlebars",
        "hbs",
        "html",
        "html-eex",
        "jade",
        "leaf",
        "liquid",
        "markdown",
        "mdx",
        "mustache",
        "njk",
        "nunjucks",
        "php",
        "razor",
        "slim",
        "twig",
        "css",
        "less",
        "postcss",
        "sass",
        "scss",
        "stylus",
        "sugarss",
        "javascript",
        "javascriptreact",
        "reason",
        "rescript",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
    },
    init_options = { userLanguages = { eelixir = "html-eex", eruby = "erb" } },
    on_new_config = function(new_config)
        if not new_config.settings then new_config.settings = {} end
        if not new_config.settings.editor then
            new_config.settings.editor = {}
        end
        if not new_config.settings.editor.tabSize then
            -- set tab size for hover
            new_config.settings.editor.tabSize =
                vim.lsp.util.get_effective_tabstop()
        end
    end,

    root_dir = root_pattern("tailwind.config.js", "tailwind.config.ts"),

    settings = {
        tailwindCSS = {
            lint = {
                cssConflict = "warning",
                invalidApply = "error",
                invalidConfigPath = "error",
                invalidScreen = "error",
                invalidTailwindDirective = "error",
                invalidVariant = "error",
                recommendedVariantOrder = "warning",
            },
            validate = true,
        },
    },
}
