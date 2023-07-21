-- https://neovim.io/doc/user/lua.html
-- https://neovim.io/doc/user/api.html#API
-- https://neovim.io/doc/user/options.html#options
local cmd = vim.cmd
local g = vim.g
local o, wo, bo = vim.o, vim.wo, vim.bo

-- Searching with typing `/<pattern>`
o.incsearch = true -- Highlight matches as you type
o.hlsearch = true -- Highlight matches once a search is complete
o.ignorecase = true -- Ignore case while searching
o.showmatch = true

-- Invisible characters & wrapping
wo.wrap = false -- Disable line wrap
o.list = false -- Show hidden characters
-- opt( "listchars", "eol:¬,tab:┆ ,trail:·,extends:»,precedes:«,space:·,nbsp:␣")

-- Enable italics
wo.t_ZH = "[[3m";
wo.t_ZR = "^[[23m";

-- ?
o.hidden = true
o.scrolloff = 5
o.shiftround = true
o.shortmess = o.shortmess .. "c"
o.shada = [['20,<50,s10,h,/100]]
-- o.completetopt = "menuone,noselect"
o.whichwrap = o.whichwrap .. "<,>,h,l"
o.laststatus = 2
o.showmode = false
o.joinspaces = false
o.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
o.inccommand = "nosplit"
o.previewheight = 5
bo.undofile = true
bo.synmaxcol = 500
o.display = "msgsep"
bo.modeline = false
o.mouse = "nivh"
o.keywordprg = ":vertical help"

-- Conceal
wo.conceallevel = 2
wo.concealcursor = "nc"

-- Width of the buffer/window
bo.textwidth = 79
wo.colorcolumn = "80"
wo.number = true
wo.relativenumber = true

-- Indentation
o.smartcase = true

-- Window splitting
o.splitbelow = true
o.splitright = true

-- Clipboard
o.clipboard = "unnamed,unnamedplus"

-- Backup & swap
o.backup = false
o.writebackup = false
o.swapfile = false

-- Performance
o.updatetime = 100 -- Default is 4000ms and leads to noticable delays
o.ttyfast = true -- Improve scrolling speed
o.lazyredraw = true -- Stop redrawing screen while executing macros
o.regexpengine = 0 -- Use newer algorithm for RegExp engine

-- Wild menu
o.wildmenu = true -- Enable "enhanced mode" of CLI completion
o.wildmode = "longest:full,full" -- Set completion mode for commands
o.wildignore = "*.o,*~,*.pyc"

-- Command line
o.cmdheight = 2 -- Give more space for displaying messages

-- Indentation
local indent = 4

bo.expandtab = false -- Don't convert TAB(s) to SPACE(s)
bo.tabstop = indent -- Width of the TAB
bo.shiftwidth = indent -- Width of the indent
bo.softtabstop = indent -- Make TAB work in the middle of line (text
bo.smartindent = true -- ?

-- Folding
-- wo.foldmethod = "indent" -- Enable folding method based on indent
-- wo.foldlevel = 2 -- Close fold level(s (0 - all)

-- Sign column
wo.signcolumn = "yes:1" -- Always show, so there's no shifting

-- Theme
o.termguicolors = true
o.background = "dark"

-- Font
o.guifont = "JetBrainsMono Nerd Font:h18"

---- ----------------------------------------------------------------------------
---- Other
---- ----------------------------------------------------------------------------
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
