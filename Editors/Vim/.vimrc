" =========================================================================== "
" Reorganizing the location for (Neo)Vim files
" --------------------------------------------
" https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-directory
" =========================================================================== "
set viminfo+=n"$VIM_DIR[HOME]/.viminfo"
set runtimepath^="$VIM_DIR[HOME]/.vim"
set runtimepath+="$VIM_DIR[HOME]/.vim/after"
let &packpath = &runtimepath

" =========================================================================== "
" Vim-Plug settings
" -----------------
" https://github.com/junegunn/vim-plug
" =========================================================================== "

" Install Vim-Plug if not found
if empty(glob("$VIM_DIR[HOME]/.vim/autoload/plug.vim"))
	silent !curl -fLo "$VIM_DIR[HOME]/.vim/autoload/plug.vim" --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source "$VIMRC"
endif

" Plugins will be downloaded under the specified directory
call plug#begin("$VIM_DIR[HOME]/.vim/plugged")
" Declare the list of plugins

	" ----------------------------------------------------------------------- "
	"                                                              Essentials
	" ----------------------------------------------------------------------- "
	"
	" Vim defaults everyone can agree on
	" ----------------------------------
	" https://github.com/tpope/vim-sensible
	Plug 'tpope/vim-sensible'
	"
	" EditorConfig
	" ---
	" https://github.com/editorconfig/editorconfig-vim
	Plug 'editorconfig/editorconfig-vim'

	" ----------------------------------------------------------------------- "
	"                                                              Navigating
	" ----------------------------------------------------------------------- "
	"
	" Display tags in a window, ordered by scope
	" ---
	" https://github.com/preservim/tagbar
	Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
	"
	" A tree explorer
	" ---
	" https://github.com/preservim/nerdtree
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	"
	" Fuzzy file, buffer, mru, tag, etc finder
	" ---
	" https://github.com/ctrlpvim/ctrlp.vim
	Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
	"
	" Add fzf and fzf-based commands
	" ---
	" https://github.com/junegunn/fzf.vim
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	"
	" Physics-based smooth scrolling
	" ---
	" https://github.com/yuttie/comfortable-motion.vim
	Plug 'yuttie/comfortable-motion.vim'
	"
	" Visualize Vim undo tree
	" ---
	" https://github.com/sjl/gundo.vim
	Plug 'sjl/gundo.vim'

	" ----------------------------------------------------------------------- "
	"                                                   Motion & Productivity
	" ----------------------------------------------------------------------- "
	"
	" Multiple cursors
	" ---
	" https://github.com/mg979/vim-visual-multi
	Plug 'mg979/vim-visual-multi'
	"
	" Motions on speed
	" ---
	" https://github.com/easymotion/vim-easymotion
	Plug 'easymotion/vim-easymotion'
	"
	" Jump to any location specified by two characters
	" ---
	" https://github.com/justinmk/vim-sneak
	Plug 'justinmk/vim-sneak'
	"
	" Enable repeating supported plugin maps with `.`
	" ---
	" https://github.com/tpope/vim-repeat
	Plug 'tpope/vim-repeat'
	"
	" Pairs of handy bracket mappings
	" ---
	" https://github.com/tpope/vim-unimpaired
	Plug 'tpope/vim-unimpaired'
	"
	" Quoting/parenthesizing made simple
	" ---
	" https://github.com/tpope/vim-surround
	Plug 'tpope/vim-surround'
	"
	" Intensely nerdy commenting powers
	" ---
	" https://github.com/scrooloose/nerdcommenter
	Plug 'scrooloose/nerdcommenter'
	"
	" Provide additional text objects
	" ---
	" https://github.com/wellle/targets.vim
	Plug 'wellle/targets.vim'
	"
	" Insert or delete brackets, parens, quotes in pair
	" ---
	" https://github.com/jiangmiao/auto-pairs
	Plug 'jiangmiao/auto-pairs'
	"
	" Alignment
	" ---
	" https://github.com/junegunn/vim-easy-align
	Plug 'junegunn/vim-easy-align'
	"
	" Emmet
	" ---
	" https://github.com/mattn/emmet-vim
	Plug 'mattn/emmet-vim'

	" ----------------------------------------------------------------------- "
	"                                                               Git tools
	" ----------------------------------------------------------------------- "
	" NERDTree showing Git status
	" https://github.com/Xuyuanp/nerdtree-git-plugin
	Plug 'Xuyuanp/nerdtree-git-plugin'
	"
	" Git wrapper
	" https://github.com/tpope/vim-fugitive
	Plug 'tpope/vim-fugitive'
	"
	" Shows git diff markers in the sign column and stages/previews/undoes
	" https://github.com/airblade/vim-gitgutter
	Plug 'airblade/vim-gitgutter'

	" ----------------------------------------------------------------------- "
	"                                                              Completion
	" ----------------------------------------------------------------------- "
	" Code completion engine
	" https://github.com/ycm-core/YouCompleteMe
	" Plug 'ycm-core/YouCompleteMe'
	"
	" CoC (Conquer of Completion) - intellisense engine for Vim
	" https://github.com/neoclide/coc.nvim
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	"
	" Snippet engine
	" https://github.com/SirVer/ultisnips
	" Plug 'SirVer/ultisnips'
	"
	" Default snippets
	" https://github.com/honza/vim-snippets
	Plug 'honza/vim-snippets'
	"
	" Perform all Vim insert mode completions with Tab
	" https://github.com/ervandew/supertab
	" Plug 'ervandew/supertab'
	"
	" Emojis
	" https://github.com/junegunn/vim-emoji
	Plug 'junegunn/vim-emoji'

	" ----------------------------------------------------------------------- "
	"                                                              Theme & UI
	" ----------------------------------------------------------------------- "
	"
	" Retro groove color theme
	" ---
	" https://github.com/morhetz/gruvbox
	Plug 'morhetz/gruvbox'
	"
	" File type icons
	" ---
	" https://github.com/ryanoasis/vim-devicons
	Plug 'ryanoasis/vim-devicons'
	"
	" A light and configurable statusline/tabline
	" ---
	" https://github.com/itchyny/lightline.vim
	Plug 'itchyny/lightline.vim'
	"
	" Distraction-free writing
	" ---
	" https://github.com/junegunn/goyo.vim
	Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

	" ----------------------------------------------------------------------- "
	"                                                                  Syntax
	" ----------------------------------------------------------------------- "
	"
	" A solid language pack
	" ---
	" https://github.com/sheerun/vim-polyglot
	Plug 'sheerun/vim-polyglot'
	"
	" Extra syntax and highlight for NERDTree files
	" ---
	" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
	"
	" Rainbow parentheses/brackets
	" https://github.com/luochen1990/rainbow
	Plug 'luochen1990/rainbow'
	"
	" Visually displaying indent levels in code
	" https://github.com/nathanaelkane/vim-indent-guides
	Plug 'nathanaelkane/vim-indent-guides'
	"
	" Make the yanked region apparent
	" https://github.com/machakann/vim-highlightedyank
	Plug 'machakann/vim-highlightedyank'
	"
	" Hyperfocus-writing
	" https://github.com/junegunn/limelight.vim
	Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
	"
	" Extra syntax and highlight for NERDTree files
	" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	"
	" Syntax highlighting plugin for JSONC files
	" https://github.com/kevinoid/vim-jsonc
	Plug 'kevinoid/vim-jsonc'

	" ----------------------------------------------------------------------- "
	"                                                                 Linters
	" ----------------------------------------------------------------------- "
	" Check syntax in Vim asynchronously and fix files, with Language Server
	" Protocol (LSP) support
	" https://github.com/dense-analysis/ale
	Plug 'dense-analysis/ale'
	"
	" ALE indicator for the Lightline Vim plugin
	" https://github.com/maximbaz/lightline-ale
	Plug 'maximbaz/lightline-ale'

	" ----------------------------------------------------------------------- "
	"                                                                   Other
	" ----------------------------------------------------------------------- "
	" The interactive scratchpad for hackers
	" https://github.com/metakirby5/codi.vim
	Plug 'metakirby5/codi.vim'
	"
	" Automatic Window Resizing Plugin
	" https://github.com/camspiers/lens.vim
	" Plug 'camspiers/animate.vim'
	" Plug 'camspiers/lens.vim'
	"
	" Helpers for UNIX
	" https://github.com/tpope/vim-eunuch
	Plug 'tpope/vim-eunuch'


" List ends here and, plugins become visible to (Neo)Vim after this call
call plug#end()

" =========================================================================== "
" Load (Neo)Vim's configuration files
" =========================================================================== "
execute 'source' fnameescape(expand("$VIM_DIR[CONFIGS]") . '/options.vim')
execute 'source' fnameescape(expand("$VIM_DIR[CONFIGS]") . '/commands.vim')
execute 'source' fnameescape(expand("$VIM_DIR[CONFIGS]") . '/maps.vim')
execute 'source' fnameescape(expand("$VIM_DIR[CONFIGS]") . '/theme.vim')

" =========================================================================== "
"Load plugins configuration files
" =========================================================================== "
"execute 'source' fnameescape(expand("$VIM_DIR[PLUGINS]") . '/coc.vim')
if has_key(plugs, 'lightline.vim')
	execute 'source' fnameescape(expand("$VIM_DIR[PLUGINS]") . '/lightline.vim')
endif

if has_key(plugs, 'ctrlp.vim')
	execute 'source' fnameescape(expand("$VIM_DIR[PLUGINS]") . '/ctrlp.vim')
endif

if has_key(plugs, 'nerdtree')
	execute 'source' fnameescape(expand("$VIM_DIR[PLUGINS]") . '/nerdtree.vim')
endif

if has_key(plugs, 'nerdcommenter')
	execute 'source' fnameescape(expand("$VIM_DIR[PLUGINS]") . '/nerdcommenter.vim')
endif




" " Vim Emoji settings
" " ------------------
" " https://github.com/junegunn/vim-emoji
" "
" " Enable emoji completion (Press Ctrl + x then Ctrl + u)
" set completefunc=emoji#complete
"
" " YouCompleteMe (YCM) settings
" " ----------------------------
" " https://github.com/ycm-core/YouCompleteMe
" "
" " Bind to hotkey(s) selected completion
" " let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" " let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" " let g:SuperTabDefaultCompletionType = '<C-n>'
"
" " UltiSnips settings
" " ------------------
" " https://github.com/SirVer/ultisnips
" "
" " Trigger configuration
 " let g:UltiSnipsExpandTrigger="<c-j>"
 " let g:ultisnipsjumpforwardtrigger="<c-b>"
 " let g:ultisnipsjumpbackwardtrigger="<c-z>"
"
" " Lens.vim settings
" " -----------------
" " https://github.com/camspiers/lens.vim
" " let g:lens#disabled_filetypes = ['nerdtree', 'fzf', 'tagbar']
"
" " Gundo settings
" " --------------
" " https://github.com/sjl/gundo.vim
" "
" " Bind toggle Gundo tree to hotkey
" nnoremap <F6> :GundoToggle<CR>
" "
" " Use Python3 instead
" let g:gundo_prefer_python3 = 1
"
" " ALE (Asynchronous Lint Engine) settings
" " ---------------------------------------
" " https://github.com/dense-analysis/ale
" "
" " Let CoC handle LSP features and send diagnostic to ALE
" let g:ale_disable_lsp = 1
" "
" " Keep the sign gutter open at all times
" let g:ale_sign_column_always = 1
" "
" " Change the signs on signcolumn
" let g:ale_sign_error = "\uf05e"
" let g:ale_sign_warning = "\uf071"
" "
" " Fixing
" let g:ale_fixers = ['prettier']
" let g:ale_fix_on_save = 1
"
