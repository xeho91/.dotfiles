-- ----------------------------------------------------------------------------
-- FORMATTERS
-- ----------------------------------------------------------------------------
-- https://github.com/Koihik/LuaFormatter
local luaFormat = {
    formatStdin = true,
    formatCommand = "lua-format --config=$DOTFILES/Formatters/.lua-format -i",
}

-- https://github.com/fsouza/prettierd
-- local prettier = { formatCommand = "prettierd ${INPUT}", formatStdin = true }

-- https://github.com/mvdan/sh
local shfmt = {
    formatCommand = "shfmt -i=0 -ci -s -bn -sr -kp",
    formatStdin = true,
}

-- https://github.com/dprint/dprint
local dprint = {
    formatStdin = true,
    formatCommand = "dprint fmt --stdin ${INPUT}",
}

-- ----------------------------------------------------------------------------
-- LINTERS
-- ----------------------------------------------------------------------------

-- https://github.com/jo-sm/stylelint_d
local stylelint = {
    lintStdin = true,
    lintCommand = "stylelint_d --formatter=unix --stdin --stdin-filename=${INPUT}",
    lintFormats = { "%f:%l:%c: %m [%tarning]", "%f:%l:%c: %m [%rror]" },
    lintIgnoreExitCode = true,
    formatCommand = "stylelint_d --fix --stdin --stdin-filename=${INPUT}",
    formatStdin = true,
}

-- https://github.com/mantoni/eslint_d.js
local eslint = {
    lintStdin = true,
    lintCommand = "eslint_d --format=visualstudio --stdin --stdin-filename=${INPUT}",
    lintFormats = { "%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m" },
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --fix-to-studiout --stdin --stdin-filename=${INPUT}",
    formatStdin = true,
}

-- https://github.com/igorshubovych/markdownlint-cli
local markdownlint = {
    lintStdin = true,
    lintCommand = "markdownlint --stdin",
    lintFormats = { "%f:%l %m", "%f:%l:%c %m", "%f: %l: %m" },
}

-- https://github.com/koalaman/shellcheck
local shellcheck = {
    -- lintStdin = true,
    lintCommand = "shellcheck --format=gcc --external-sources",
    lintSource = "shellcheck",
    lintFormats = {
        "%f:%l:%c: %trror: %m",
        "%f:%l:%c: %tarning: %m",
        "%f:%l:%c: %tote: %m",
    },
}

-- ----------------------------------------------------------------------------
-- EFM-LANGSERVER
-- ----------------------------------------------------------------------------
return {
    cmd = { "efm-langserver" },
    init_options = {
        gotoDefinition = false,
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
    },
    filetypes = {
        "lua",
        "sh",
        "html",
        "markdown",
        "css",
        "pcss",
        "javascript",
        "typescript",
        "json",
        "svelte",
    },
    rootMarkers = { "package.json", ".git" },
    settings = {
        languages = {
            lua = { luaFormat },
            javascript = { dprint },
            typescript = { dprint },
            svelte = { eslint, stylelint, dprint },
            json = { dprint },
            yaml = { dprint },
            css = { stylelint, dprint },
            pcss = { stylelint, dprint },
            markdown = { markdownlint, dprint },
            html = { stylelint, eslint, dprint },
            sh = { shellcheck, shfmt },
        },
    },
}

