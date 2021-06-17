local fn = vim.fn
local lsp = vim.lsp
local vimp = require("vimp")
local autocmd = require("utils").autocmd
local get_icon = require("icons").get_icon
local lsp_config = require("lspconfig")
local lsp_status = require("lsp-status")
local lsp_kind = require("lspkind")
local lsp_saga = require("lspsaga")
local lsp_trouble = require("trouble")
local lsp_signature = require("lsp_signature")

-- vim.lsp.set_log_level("debug")

local symbols = {
    Text = " ",
    Method = "ƒ ",
    Function = " ",
    Constructor = " ",
    Variable = " ",
    Class = " ",
    Interface = "ﰮ ",
    Module = " ",
    Property = " ",
    Unit = " ",
    Value = " ",
    Enum = "了",
    Keyword = " ",
    Snippet = "﬌ ",
    Color = " ",
    File = " ",
    Folder = "ﱮ ",
    EnumMember = " ",
    Constant = " ",
    Struct = " ",
}

-- https://github.com/onsails/lspkind-nvim
lsp_kind.init({ with_text = true, symbol_map = symbols })

local sign_define = fn.sign_define

sign_define("LspDiagnosticsSignError", { text = "", numhl = "RedSign" })
sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "YellowSign" })
sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "WhiteSign" })
sign_define("LspDiagnosticsSignHint", { text = "", numhl = "BlueSign" })

-- https://github.com/nvim-lua/lsp-status.nvim
lsp_status.config(
    {
        kind_labels = symbols,
        diagnostics = true,
        indicator_separator = "",
        indicator_errors = get_icon("error"),
        indicator_warnings = get_icon("warning"),
        indicator_info = get_icon("info"),
        indicator_hint = get_icon("hint"),
        indicator_ok = get_icon("success"),
        current_function = true,
        status_symbol = get_icon("diagnostic"),
        select_symbol = function(cursor_pos, symbol)
            if symbol.valueRange then
                local value_range = {
                    ["start"] = {
                        character = 0,
                        line = fn.byte2line(symbol.valueRange[1]),
                    },
                    ["end"] = {
                        character = 0,
                        line = fn.byte2line(symbol.valueRange[2]),
                    },
                }

                return require("lsp-status/util").in_range(
                           cursor_pos, value_range
                       )
            end
        end,
    }
)
lsp_status.register_progress()

lsp.handlers["textDocument/publishDiagnostics"] =
    lsp.with(
        lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
            signs = true,
            update_in_insert = true,
            underline = true,
        }
    )

-- https://github.com/glepnir/lspsaga.nvim
lsp_saga.init_lsp_saga(
    {
        use_saga_diagnostic_sign = true,
        error_sign = get_icon("error"),
        warn_sign = get_icon("warning"),
        hint_sign = get_icon("hint"),
        infor_sign = get_icon("info"),
        dianostic_header_icon = get_icon("diagnostic"),
        code_action_icon = get_icon("bulb"),
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 20,
            virtual_text = true,
        },
        finder_definition_icon = get_icon("definition"),
        finder_reference_icon = get_icon("reference"),
        max_preview_lines = 10,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            quit = "q",
            scroll_down = "<C-u>",
            scroll_up = "<C-d>",
        },
        code_action_keys = { quit = "q", exec = "<CR>" },
        rename_action_keys = {
            quit = "<Esc>",
            exec = "<CR>", -- quit can be a table
        },
        definition_preview_icon = get_icon("preview"),
        border_style = "round",
        rename_prompt_prefix = get_icon("rename") .. "Rename:",
    }
)

-- https://github.com/folke/lsp-trouble.nvim
lsp_trouble.setup(
    {
        height = 10, -- height of the trouble list
        icons = true, -- use dev-icons for filenames
        mode = "workspace", -- "workspace" or "document"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        action_keys = {
            -- key mappings for actions in the trouble list
            close = "q", -- close the list
            cancel = "<Esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = { "<CR>", "<Tab>" }, -- jump to the diagnostic or open / close folds
            toggle_mode = "m", -- toggle between "workspace" and "document" mode
            toggle_preview = "P", -- toggle auto_preview
            preview = "p", -- preview the diagnostic location
            close_folds = { "zM", "zm" }, -- close all folds
            open_folds = { "zR", "zr" }, -- open all folds
            toggle_fold = { "zA", "za" }, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j", -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
        auto_fold = true, -- automatically fold a file trouble list at creation
        use_lsp_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
    }
)

local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    if lsp_status ~= nil then lsp_status.on_attach(client, bufnr) end

    -- https://github.com/ray-x/lsp_signature.nvim
    lsp_signature.on_attach(
        {
            bind = true,
            doc_lines = 100,
            hint_enable = true,
            hint_prefix = "🐼 ",
            hint_scheme = "Markdown",
            handler_opts = { border = "single" },
        }
    )

    -- Mappings

    -- Definition
    vimp.nnoremap({ "override" }, "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    vimp.nnoremap(
        { "override" }, "<leader>gd", "<cmd>Lspsaga preview_definition<CR>"
    )

    -- Declaration
    vimp.nnoremap({ "override" }, "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")

    -- References
    vimp.nnoremap(
        { "override" }, "<leader>sr", "<cmd>lua vim.lsp.buf.references()<CR>"
    )
    vimp.nnoremap(
        { "override" }, "<leader>gr",
        "<cmd>Telescope lsp_references theme=get_dropdown previewer=false<CR>"
    )

    -- Implementation
    vimp.nnoremap(
        { "override" }, "<leader>si", "<cmd>lua vim.lsp.buf.implementation()"
    )
    vimp.nnoremap(
        { "override" }, "<leader>gi",
        "<cmd>Telescope lsp_implementations theme=get_dropdown previewer=false<CR>"
    )

    -- Type Definition
    vimp.nnoremap(
        { "override" }, "<leader>gt",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>"
    )

    -- Rename
    vimp.nnoremap({ "override" }, "<leader>rn", "<cmd>Lspsaga rename<CR>")

    -- Preview Declarations/References - Async Lsp Finder
    vimp.nnoremap({ "override" }, "<leader>ph", "<cmd>Lspsaga lsp_finder<CR>")

    -- Code action
    vimp.nnoremap({ "override" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
    vimp.vnoremap(
        { "override" }, "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>"
    )

    -- Hover doc
    vimp.nnoremap({ "override" }, "<leader>H", "<cmd>Lspsaga hover_doc<CR>")
    -- Scroll Hover Doc FIXME: Conflicts with vim-smoothie
    -- map("n", "<C-d>", "<cmd>lua require('lspsaga/action').smart_scroll_with_saga(1)<CR>", m_opts)
    -- map("n", "<C-u>", "<cmd>lua require('lspsaga/action').smart_scroll_with_saga(-1)<CR>", m_opts)

    -- Signature help
    vimp.nnoremap({ "override" }, "<leader>S", "<cmd>Lspsaga signature_help<CR>")

    -- Diagnostic
    vimp.nnoremap({ "override" }, "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")
    vimp.nnoremap({ "override" }, "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    vimp.nnoremap({ "override" }, "<leader>D", "<cmd>LspTroubleOpen<CR>")

    -- Formatting
    local format_key = "<leader>F"

    -- HACK: Exclude servers from formatting, except EFM
    -- FIXME: Find a better way to disable it
    if client.name ~= "efm" then
        client.resolved_capabilities.document_formatting = false
    end

    if client.resolved_capabilities.document_formatting then
        vimp.nnoremap(
            { "override" }, format_key, function()
                vim.cmd("lua vim.lsp.buf.formatting()")
                print("Formatting done!")
            end
        )

        -- Enable formatting on save
        autocmd(
            "FormatOnSave", {
                [[BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 200)]],
                [[BufWritePost <buffer> lua print("Formatting on save done!")]],
            }, false
        )
    end

    -- Range formatting
    if client.resolved_capabilities.document_range_formatting then
        vimp.vnoremap(
            { "override" }, format_key, function()
                vim.cmd("lua vim.lsp.buf.range_formatting()")
                print("Range formatting done!")
            end
        )
    end

    if client.resolved_capabilities.document_highlight then
        autocmd(
            "LSP_Cursor_DocumentHiglight", {
                "CursorHold <buffer> lua vim.lsp.buf.document_highlight()",
                "CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()",
                "CursorMoved <buffer> lua vim.lsp.buf.clear_references()",
            }, false
        )
    end

    if client.resolved_capabilities.hover then
        autocmd(
            "LSP_Cursor_Diagnostics",
            { "CursorHold <buffer> Lspsaga show_cursor_diagnostics" }, false
        )
    end

end

-- Float term
vimp.nnoremap("<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
vimp.tnoremap("<A-d>", "<cmd>Lspsaga close_floaterm<CR>")

local servers = {
    -- Lua
    sumneko_lua = require("servers/sumneko_lua"),
    -- ash
    bashls = require("servers/bashls"),
    -- JavaScript / TypeScript
    tsserver = require("servers/tsserver"),
    -- (Deno) JavaScript / TypeScript
    denols = require("servers/denols"),
    -- JSON
    jsonls = require("servers/jsonls"),
    -- HTML
    html = require("servers/htmlls"),
    -- CSS
    cssls = require("servers/cssls"),
    -- Svelte
    svelte = require("servers/svelte"),
    -- YAML
    yamlls = require("servers/yamlls"),
    -- General purpose (Linting & Fixing)
    efm = require("servers/efm"),
}

local snippet_capabilities = {
    textDocument = {
        completion = {
            completionItem = { snippetSupport = true },
            resolveSupport = {
                properties = { "documentation", "detail", "additionalTextEdits" },
            },
        },
    },
}

for server, config in pairs(servers) do
    config.on_attach = on_attach
    config.capabilities = vim.tbl_deep_extend(
                              "keep", config.capabilities or {},
                              lsp_status.capabilities, snippet_capabilities
                          )

    lsp_config[server].setup(config)
end

