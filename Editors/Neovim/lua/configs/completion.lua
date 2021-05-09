-- https://github.com/hrsh7th/nvim-compe
local vimp = require("vimp")
local fn = vim.fn

vim.cmd("set shortmess+=c")
vim.o.completeopt = "menuone,noselect"

require("compe").setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        buffer = true,
        path = true,
        tags = true,
        spell = true,
        calc = true,
        emoji = true,
        omni = false, -- It has side effects
        -- Neovim specific
        nvim_lsp = true,
        nvim_lua = true,
        -- External
        treesitter = true,
        vsnip = true
        -- tabnine = true,
    }
})

-- Mappings

-- Open completion list
vimp.imap({"expr", "silent"}, "<C-o>", "compe#complete()")
-- Close completion list
vimp.imap({"expr", "silent"}, "<C-c>", "compe#close('<C-c>')")
-- Confirm selection
vimp.imap({"expr", "silent", "override"}, "<CR>", "compe#confirm('<CR>')")

-- NOTE: This scrolls the documentation part only
vimp.imap({"expr", "silent", "override"}, "<C-u>",
          "compe#scroll({ 'delta': +4 })")
vimp.imap({"expr", "silent", "override"}, "<C-d>",
          "compe#scroll({ 'delta': -4 })")

-- ----------------------------------------------------------------------------
-- Setting <Tab> and <S-Tab> for completion
-- ----------------------------------------------------------------------------
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_backspace = function()
    local col = fn.col(".") - 1

    if col == 0 or fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- Use <(S-)Tab> to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_backspace() then
        return t "<Tab>"
    else
        return fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
    if fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

vimp.imap({"expr"}, "<Tab>", "v:lua.tab_complete()")
vimp.smap({"expr"}, "<Tab>", "v:lua.tab_complete()")
vimp.imap({"expr"}, "<S-Tab>", "v:lua.s_tab_complete()")
vimp.smap({"expr"}, "<S-Tab>", "v:lua.s_tab_complete()")

-- ----------------------------------------------------------------------------
-- https://github.com/hrsh7th/vim-vsnip
-- ----------------------------------------------------------------------------

-- Expand or jump
vimp.imap({"expr"}, "<C-j>",
          "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'")
vimp.smap({"expr"}, "<C-j>",
          "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-j>'")
--[[ -- Jump forward
vimp.imap(
    { "expr", "override" }, "<Tab>",
    "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'"
)
vimp.smap(
    { "expr", "override" }, "<Tab>",
    "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'"
)
-- Jump backwards
vimp.imap(
    { "expr", "override" }, "<S-Tab>",
    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'"
)
vimp.smap(
    { "expr", "override" }, "<S-Tab>",
    "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'"
) ]]

-- ----------------------------------------------------------------------------
-- https://github.com/L3MON4D3/LuaSnip
-- ----------------------------------------------------------------------------

-- Expand or jump
--[[ vimp.nmap({ "expr", "silent" }, "<C-j>",
		  "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-j>'") ]]
