scriptencoding utf-8

" =========================================================================== "
" Vim options
" -----------
" http://vimdoc.sourceforge.net/htmldoc/options.html
" ---
" NOTE: Is faster to just use `:help <query>`
" =========================================================================== "

" =========================================================================== "
" Searching with typing `/<pattern>`
" =========================================================================== "

" Highlight matches as you type
set incsearch

" Highlight matches once a search is complete
set hlsearch

" =========================================================================== "
" Invisible characters & wrapping
" =========================================================================== "

" Disable line-wrap
set nowrap

" Show invisible characters such spaces, tabs, etc
set list

" Define the display of these invisible characters
set listchars=
	\eol:¬,
	\tab:┆\ ,
	\trail:·,
	\extends:»,
	\precedes:«,
	\space:·,
	\nbsp:␣

" =========================================================================== "
" Navigation
" =========================================================================== "
"
" Visual indicator to show where your cursor is (line and column)
" NOTE: This slows down Vim
" set cursorline
" set cursorcolumn

" Visually highlight the preferred line length (column on the right)
set colorcolumn=80

" Show line number on the left
set number

" Set scroll offset
set scrolloff=8

" =========================================================================== "
" Indentation
" =========================================================================== "
"
" Don't convert TAB to spaces
set noexpandtab

" The width of the TAB
set tabstop=4

" Make TAB working in the middle of line (text)
set softtabstop=4

" Indent width
set shiftwidth=4

" =========================================================================== "
" Backup & swap
" =========================================================================== "
"
" Don't create a backup before overwriting a file
set nobackup

" Don't leave a backup after the file was written
set nowritebackup

" Don't create swap files
set noswapfile

" =========================================================================== "
" Folding
" =========================================================================== "

" Enable folding method based on indent
set foldmethod=indent

" Close folds (0 - all, higher number will close fewer folds)
set foldlevel=0

" =========================================================================== "
" Performance
" =========================================================================== "

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Improve scrolling speed
set ttyfast

" Stop redrawing screen while executing macros
set lazyredraw

" Use newer algorithm for RegExp engine
set regexpengine=1

" =========================================================================== "
" Wild menu
" =========================================================================== "

" Set completion mode for commands
set wildmode=longest:full,full

" Enable 'enhanced mode' of command-line completion
set wildmenu

