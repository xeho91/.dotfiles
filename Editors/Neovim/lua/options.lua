-- https://neovim.io/doc/user/lua.html
-- https://neovim.io/doc/user/api.html#API
local cmd = vim.cmd
local g = vim.g
local o, wo, bo = vim.o, vim.wo, vim.bo

local utils = require("utils")
local opt = utils.opt

-- https://neovim.io/doc/user/options.html#options
local buffer = { o, bo }
local window = { o, wo }

-- Searching with typing `/<pattern>`
opt("incsearch", true) -- Highlight matches as you type
opt("hlsearch", true) -- Highlight matches once a search is complete
opt("ignorecase", true) -- Ignore case while searching
opt("showmatch", true)

-- Invisible characters & wrapping
opt("wrap", false, window) -- Disable line wrap
opt("list", false) -- Show hidden characters
-- opt( "listchars", "eol:¬,tab:┆ ,trail:·,extends:»,precedes:«,space:·,nbsp:␣")

-- Enable italics
opt("t_ZH", "[[3m")
opt("t_ZR", "^[[23m")

-- ?
opt("hidden", true)
opt("scrolloff", 5)
opt("shiftround", true)
opt("shortmess", o.shortmess .. "c")
opt("shada", [['20,<50,s10,h,/100]])
-- opt("completetopt", "menuone,noselect")
opt("whichwrap", o.whichwrap .. "<,>,h,l")
opt("laststatus", 2)
opt("showmode", false)
opt("joinspaces", false)
opt("guicursor", [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]])
opt("inccommand", "nosplit")
opt("previewheight", 5)
opt("undofile", true, buffer)
opt("synmaxcol", 500, buffer)
opt("display", "msgsep")
opt("modeline", false, buffer)
opt("mouse", "nivh")
opt("keywordprg", ":vertical help")

-- Conceal
opt("conceallevel", 2, window)
opt("concealcursor", "nc", window)

-- Width of the buffer/window
opt("textwidth", 79, buffer)
opt("colorcolumn", "80", window)
opt("number", true, window)
opt("relativenumber", true, window)

-- Indentation
opt("smartcase", true)

-- Window splitting
opt("splitbelow", true)
opt("splitright", true)

-- Clipboard
opt("clipboard", "unnamed,unnamedplus")

-- Backup & swap
opt("backup", false)
opt("writebackup", false)
opt("swapfile", false)

-- Performance
opt("updatetime", 100) -- Default is 4000ms and leads to noticable delays
opt("ttyfast", true) -- Improve scrolling speed
opt("lazyredraw", true) -- Stop redrawing screen while executing macros
opt("regexpengine", 0) -- Use newer algorithm for RegExp engine

-- Wild menu
opt("wildmenu", true) -- Enable "enhanced mode" of CLI completion
opt("wildmode", "longest:full,full") -- Set completion mode for commands
opt("wildignore", "*.o,*~,*.pyc")

-- Command line
opt("cmdheight", 2) -- Give more space for displaying messages

-- Indentation
local indent = 4

opt("expandtab", false, buffer) -- Don't convert TAB(s) to SPACE(s)
opt("tabstop", indent, buffer) -- Width of the TAB
opt("shiftwidth", indent, buffer) -- Width of the indent
opt("softtabstop", indent, buffer) -- Make TAB work in the middle of line (text)
opt("smartindent", true, buffer) -- ?

-- Folding
-- opt("foldmethod", "indent", window) -- Enable folding method based on indent
opt("foldlevel", 2, window) -- Close fold level(s) (0 - all)

-- Sign column
opt("signcolumn", "yes:1", window) -- Always show, so there's no shifting

-- Theme
opt("termguicolors", true)
opt("background", "dark")

-- Font
opt("guifont", "FiraCode Nerd Font:h18")

-- ----------------------------------------------------------------------------
-- Other
-- ----------------------------------------------------------------------------
cmd("filetype plugin indent on")
cmd("syntax enable")

-- ----------------------------------------------------------------------------
-- Neovide settings
--
-- https://github.com/Kethku/neovide/wiki/Configuration#global-vim-settings
-- ----------------------------------------------------------------------------
if g.neovide then
    g.neovide_refresh_rate = 60
    g.neovide_transparency = 0.95
    g.neovide_no_idle = false
    g.neovide_fullscreen = false
    g.neovide_cursor_animation_length = 0.13
    g.neovide_cursor_trail_length = 0.8
    g.neovide_cursor_antialiasing = true
    g.neovide_cursor_vfx_mode = "sonicboom"
    g.neovide_cursor_vfx_opacity = 200.0
    g.neovide_cursor_vfx_particle_lifetime = 1.2
    g.neovide_cursor_vfx_particle_density = 7.0
    g.neovide_cursor_vfx_particle_speed = 10.0
    g.neovide_cursor_vfx_particle_phase = 1.5
    g.neovide_cursor_vfx_particle_curl = 1.0
end
