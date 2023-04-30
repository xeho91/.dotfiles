local g = vim.g
local vimp = require("vimp")
local autocmd = require("utils").autocmd

-- Map leader
g.mapleader = [[\]]
g.maplocalleader = [[,]]

-- if g.neovide then
--[[ local function toggle_fullScreen()
        if g.neovide_fullscreen then
            return false
        else
            return true
        end
    end

    vimp.nnoremap(
        "<F11>", "<cmd>let g:neovide_fullscreen = luaeval(toggle_fullScreen())<CR>"
    ) ]]
-- end

vimp.nmap("<F1>", "<cmd>ToggleHelp<CR>")
autocmd(
    "Help_Mappings", {
        "FileType help noremap <buffer> q <cmd>quit<CR>",
        "FileType help nnoremap <buffer> <CR> <C-]>",
        "FileType help nnoremap <buffer> <BS> <C-T>",
        [[FileType help nnoremap <buffer> o /'\l\{2,\}'<CR>]],
        [[FileType help nnoremap <buffer> O ?'\l\{2,\}'<CR>]],
        [[FileType help nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>]],
        [[FileType help nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>]],
    }
)

