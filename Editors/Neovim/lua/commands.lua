local vimp = require("vimp")
local autocmd = require("utils").autocmd

-- ----------------------------------------------------------------------------
-- Toggle help (editor's manual)
-- and search for key under the cursor
--
-- Credits: https://vim.fandom.com/wiki/Disable_F1_built-in_help_key
-- ----------------------------------------------------------------------------

vimp.map_command(
    "ToggleHelp", function()
        if vim.bo.buftype == "help" then
            vim.cmd("bwipeout")
        else
            vim.cmd(
                [[
				try
					exec 'vertical help ' . expand('<cWORD>')
				catch /:E149:\|:E661:/
					" E149 no help for <subject>
					" E661 no <language> help for <subject>
					exec 'vertical help ' . expand('<cword>')
				endtry
			]]
            )
        end
    end
)

-- api.nvim_exec([[
-- augroup auto_spellcheck
--     autocmd!
--     autocmd BufNewFile,BufRead *.md setlocal spell
--     autocmd BufNewFile,BufRead *.org setfiletype markdown
--     autocmd BufNewFile,BufRead *.org setlocal spell
-- augroup END
-- ]], false)

-- Trim whitespace on Buffer save
function TrimWhitespace()
    local save = vim.fn.winsaveview()

    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.fn.winrestview(save)
end

-- ----------------------------------------------------------------------------
-- Autocommands
-- ----------------------------------------------------------------------------

autocmd("TrimWhiteSpaceOnSave", "BufWritePre * lua TrimWhitespace()", true)

-- Set mappings for the Help
autocmd(
    "Help_Mappings", {
        "FileType help noremap <buffer> q <cmd>quit<CR>",
        [[FileType help nnoremap <buffer> <CR> <C-]>]],
        [[FileType help nnoremap <buffer> <BS> <C-T>]],
        [[FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>]],
        [[FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>]],
        [[FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>]],
        [[FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>]],
    }
)

-- Highlight on yank
autocmd(
    "HighlightYank", {
        "BufWinEnter * checktime",
        "TextYankPost * silent! lua vim.highlight.on_yank()",
    }, true
)

-- Toggle cursorline/cursorcolumn only on active window
autocmd(
    "Cursor_LineColumn", {
        "WinEnter,BufEnter * setlocal cursorline cursorcolumn",
        "WinLeave,BufLeave * setlocal nocursorline cursorcolumn",
    }, true
)

autocmd(
    "Terminal", {
        "TermOpen * setlocal nonumber norelativenumber",
        "TermOpen * startinsert",
    }, true
)

-- ----------------------------------------------------------------------------
-- Filetypes & Syntaxes
-- ----------------------------------------------------------------------------

-- Dotenv
-- autocmd(
--     "Dotenv_Filetype",
--     "BufNewFile,BufRead *.env,*.env.me,*.env.project set filetype=dotenv", true
-- )
-- autocmd(
--     "Dotenv_Syntax",
--     "BufNewFile,BufRead *.env,*.env.me,*.env.project set syntax=sh", true
-- )

-- MDsveX
autocmd("MDsveX_Filetype", "BufNewFile,BufRead *.svx set filetype=mdsvex", true)
autocmd("MDsveX_Syntax", "BufNewFile,BufRead *.svx set syntax=markdown", true)

-- JSONC
autocmd("JSONC_Syntax", "BufRead,BufNewFile *.json set filetype=jsonc", true)
