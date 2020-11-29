" =========================================================================== "
" Reorganizing the location for (Neo)Vim files
" --------------------------------------------
" https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-directory
" =========================================================================== "
set viminfo+=n"$VIM_DIR[HOME]/.viminfo"

" =========================================================================== "
" Vim-Plug settings
" -----------------
" https://github.com/junegunn/vim-plug
" =========================================================================== "

" Install Vim-Plug if not found
let g:vimPlugFilePath = fnameescape(expand('$VIM_DIR[HOME]') . '.vim/autoload/plug.vim')
if empty(glob(g:vimPlugFilePath))
	silent !curl -fLo vimPlugFilePath --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	augroup vimPlug
		autocmd vimPlug VimEnter * PlugInstall --sync | source '$VIMRC'
	augroup END
endif

" Plugins will be downloaded under the specified directory
call plug#begin('$VIM_DIR[HOME]/.vim/plugged')
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
	" ------------
	" https://github.com/editorconfig/editorconfig-vim
	Plug 'editorconfig/editorconfig-vim'

	" ----------------------------------------------------------------------- "
	"                                                               Searchers
	" ----------------------------------------------------------------------- "
	"
	" Plugin for the the Perl module `ack` or `ag`
	" ----------------------------------
	" https://github.com/mileszs/ack.vim
	Plug 'mileszs/ack.vim'
	"
	" An `ack/ag/pt/rg` powered code search and view tool
	" ---------------------------------------------------
	" https://github.com/dyng/ctrlsf.vim
	Plug 'dyng/ctrlsf.vim'

	" ----------------------------------------------------------------------- "
	"                                                     Interactive filters
	" ----------------------------------------------------------------------- "
	"
	" Add `fzf` and fzf-based commands
	" --------------------------------
	" https://github.com/junegunn/fzf.vim
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	"
	" Fuzzy file, buffer, mru, tag, etc finder
	" ----------------------------------------
	" https://github.com/ctrlpvim/ctrlp.vim
	Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
	"
	" Efficient fuzzy finder that helps to locate files, buffers, mru, etc.
	" ---------------------------------------------------------------------
	" https://github.com/Yggdroot/LeaderF
	Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

	" ----------------------------------------------------------------------- "
	"                                                NERDTree (file explorer)
	" ----------------------------------------------------------------------- "
	"
	" File tree explorer
	" ------------------
	" https://github.com/preservim/nerdtree
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	"
	" NERDTree showing Git status
	" ---------------------------
	" https://github.com/Xuyuanp/nerdtree-git-plugin
	if has_key(g:plugs, 'nerdtree')
		Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
	endif
	"
	" Extra syntax and highlight for NERDTree files
	" ---------------------------------------------
	" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
	if has_key(g:plugs, 'nerdtree')
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
	endif

	" ----------------------------------------------------------------------- "
	"                                                              Navigating
	" ----------------------------------------------------------------------- "
	"
	" Viewer & Finder for LSP (Language Server Protocol) symbols and tags
	" -------------------------------------------------------------------
	" https://github.com/liuchengxu/vista.vim
	Plug 'liuchengxu/vista.vim'
	"
	" Graph Vim undo tree in style
	" ----------------------------
	" https://github.com/simnalamburt/vim-mundo
	Plug 'simnalamburt/mundo.vim', { 'on': 'MundoToggle' }

	" ----------------------------------------------------------------------- "
	"                                                   Motion & Productivity
	" ----------------------------------------------------------------------- "
	"
	" Multiple cursors
	" ----------------
	" https://github.com/mg979/vim-visual-multi
	Plug 'mg979/vim-visual-multi'
	"
	" Motions on speed
	" ----------------
	" https://github.com/easymotion/vim-easymotion
	Plug 'easymotion/vim-easymotion'
	"
	" Jump to any location specified by two characters
	" ------------------------------------------------
	" https://github.com/justinmk/vim-sneak
	Plug 'justinmk/vim-sneak'
	"
	" Enable repeating supported plugin maps with `.`
	" -----------------------------------------------
	" https://github.com/tpope/vim-repeat
	Plug 'tpope/vim-repeat'
	"
	" Pairs of handy bracket mappings
	" -------------------------------
	" https://github.com/tpope/vim-unimpaired
	Plug 'tpope/vim-unimpaired'
	"
	" Quoting/parenthesizing made simple
	" ----------------------------------
	" https://github.com/tpope/vim-surround
	Plug 'tpope/vim-surround'
	"
	" Intensely nerdy commenting powers
	" ---------------------------------
	" https://github.com/scrooloose/nerdcommenter
	Plug 'scrooloose/nerdcommenter'
	"
	" Provide additional text objects
	" -------------------------------
	" https://github.com/wellle/targets.vim
	Plug 'wellle/targets.vim'
	"
	" Insert or delete brackets, parens, quotes in pair
	" -------------------------------------------------
	" https://github.com/jiangmiao/auto-pairs
	Plug 'jiangmiao/auto-pairs'
	"
	" Alignment
	" ---------
	" https://github.com/junegunn/vim-easy-align
	Plug 'junegunn/vim-easy-align'
	"
	" Emmet
	" -----
	" https://github.com/mattn/emmet-vim
	Plug 'mattn/emmet-vim', { 'for': ['html'] }
	"
	" Help stop repeating the basic movement keys
	" -------------------------------------------
	" https://github.com/takac/vim-hardtime
	Plug 'takac/vim-hardtime'
	"
	" Visually select increasingly larger regions of text using the same key
	" combination
	" -----------
	" https://github.com/terryma/vim-expand-region
	Plug 'terryma/vim-expand-region'

	" ----------------------------------------------------------------------- "
	"                                                               Git tools
	" ----------------------------------------------------------------------- "
	"
	" Git wrapper
	" -----------
	" https://github.com/tpope/vim-fugitive
	Plug 'tpope/vim-fugitive'
	"
	" Shows git diff markers in the sign column and stages/previews/undoes
	" --------------------------------------------------------------------
	" https://github.com/airblade/vim-gitgutter
	Plug 'airblade/vim-gitgutter'

	" ----------------------------------------------------------------------- "
	"                                                                 Linters
	" ----------------------------------------------------------------------- "
	"
	" Check syntax in Vim asynchronously and fix files, with Language Server
	" Protocol (LSP) support
	" ----------------------
	" https://github.com/dense-analysis/ale
	Plug 'dense-analysis/ale'
	"
	" ALE indicator for the Lightline Vim plugin
	" ------------------------------------------
	" https://github.com/maximbaz/lightline-ale
	if has_key(g:plugs, 'ale')
		Plug 'maximbaz/lightline-ale'
	endif

	" ----------------------------------------------------------------------- "
	"                                          LSP (Language Server Protocol)
	" ----------------------------------------------------------------------- "
	"
	" Async language server protocol plugin
	" -------------------------------------
	" https://github.com/prabirshrestha/vim-lsp
	Plug 'prabirshrestha/vim-lsp'
	"
	" Auto configurations for Language Server for `vim-lsp`
	" -----------------------------------------------------
	" https://github.com/mattn/vim-lsp-settings
	if has_key(g:plugs, 'vim-lsp')
		Plug 'mattn/vim-lsp-settings'
	endif
	"
	" Provide Language Server Protocol autocompletion source for
	" `asyncomplete.vim` and `vim-lsp`
	" --------------------------------
	" https://github.com/prabirshrestha/asyncomplete-lsp.vim
	if has_key(g:plugs, 'vim-lsp') && has_key(g:plugs, 'asyncomplete.vim')
		Plug 'prabirshrestha/asyncomplete-lsp.vim'
	endif

	" ----------------------------------------------------------------------- "
	"                                                             Completions
	" ----------------------------------------------------------------------- "
	"
	" Async completion engine
	" -----------------------
	" https://github.com/prabirshrestha/asyncomplete.vim
	Plug 'prabirshrestha/asyncomplete.vim'
	"
	" ALE
	" ---
	" https://github.com/andreypopp/asyncomplete-ale.vim
	if has_key(g:plugs, 'asyncomplete.vim') && has_key(g:plugs, 'ale')
		Plug 'andreypopp/asyncomplete-ale.vim'
	endif
	"
	" Buffer
	" ------
	" https://github.com/prabirshrestha/asyncomplete-buffer.vim
	if has_key(g:plugs, 'asyncomplete.vim')
		Plug 'prabirshrestha/asyncomplete-buffer.vim'
	endif
	"
	" Emmet
	" -----
	" https://github.com/prabirshrestha/asyncomplete-emmet.vim
	if has_key(g:plugs, 'asyncomplete.vim') && has_key(g:plugs, 'emmet-vim')
		Plug 'prabirshrestha/asyncomplete-emmet.vim'
	endif
	"
	" Perform all Vim insert mode completions with Tab
	" ------------------------------------------------
	" https://github.com/ervandew/supertab
	" Plug 'ervandew/supertab'
	"
	" Emojis
	" ---
	" https://github.com/junegunn/vim-emoji
	Plug 'junegunn/vim-emoji'

	" ----------------------------------------------------------------------- "
	"                                                                Snippets
	" ----------------------------------------------------------------------- "
	"
	" Snippet engine
	" --------------
	" https://github.com/SirVer/ultisnips
	" Plug 'SirVer/ultisnips'
	"
	" Default snippets
	" ---
	" https://github.com/honza/vim-snippets
	" Plug 'honza/vim-snippets'

	" ----------------------------------------------------------------------- "
	"                                                              Theme & UI
	" ----------------------------------------------------------------------- "
	"
	" Retro groove color theme
	" ------------------------
	" https://github.com/morhetz/gruvbox
	Plug 'morhetz/gruvbox'
	"
	" File type icons
	" ---------------
	" https://github.com/ryanoasis/vim-devicons
	Plug 'ryanoasis/vim-devicons'
	"
	" A light and configurable statusline/tabline
	" -------------------------------------------
	" https://github.com/itchyny/lightline.vim
	Plug 'itchyny/lightline.vim'
	"
	" Hyperfocus-writing
	" ------------------
	" https://github.com/junegunn/limelight.vim
	Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }
	"
	" Distraction-free writing
	" ------------------------
	" https://github.com/junegunn/goyo.vim
	Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

	" ----------------------------------------------------------------------- "
	"                                                                  Syntax
	" ----------------------------------------------------------------------- "
	"
	" A solid language pack
	" ---------------------
	" https://github.com/sheerun/vim-polyglot
	Plug 'sheerun/vim-polyglot'
	"
	" Speed up (Neo)Vim by updating folds only when called
	" ----------------------------------------------------
	" https://github.com/Konfekt/FastFold
	Plug 'Konfekt/FastFold'
	"
	" Rainbow parentheses/brackets
	" ----------------------------
	" https://github.com/luochen1990/rainbow
	Plug 'luochen1990/rainbow'
	"
	" Asynchronously displaying the colours in the file
	" -------------------------------------------------
	" https://github.com/RRethy/vim-hexokinase
	Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
	"
	" Make the yanked region apparent
	" -------------------------------
	" https://github.com/machakann/vim-highlightedyank
	Plug 'machakann/vim-highlightedyank'
	"
	" Syntax highlighting for JSONC files
	" -----------------------------------
	" https://github.com/kevinoid/vim-jsonc
	Plug 'kevinoid/vim-jsonc', { 'for': ['jsonc', 'json'] }
	"
	" Range, pattern and substitute preview
	" -------------------------------------
	" https://github.com/markonm/traces.vim
	Plug 'markonm/traces.vim'

	" ----------------------------------------------------------------------- "
	"                                                                   Other
	" ----------------------------------------------------------------------- "
	"
	" Physics-based smooth scrolling
	" ------------------------------
	" https://github.com/yuttie/comfortable-motion.vim
	Plug 'yuttie/comfortable-motion.vim'
	"
	" The interactive scratchpad for hackers
	" --------------------------------------
	" https://github.com/metakirby5/codi.vim
	Plug 'metakirby5/codi.vim', { 'on': 'Codi' }
	"
	" Automatic Window Resizing Plugin
	" --------------------------------
	" https://github.com/camspiers/lens.vim
	" Plug 'camspiers/animate.vim'
	" Plug 'camspiers/lens.vim'
	"
	" Helpers for UNIX
	" ----------------
	" https://github.com/tpope/vim-eunuch
	Plug 'tpope/vim-eunuch'
	"
	" The fancy start screen
	" ----------------------
	" https://github.com/mhinz/vim-startify
	Plug 'mhinz/vim-startify'

	" List ends here and, plugins become visible to (Neo)Vim after this call
call plug#end()

" If defined autocmds are without a group, Vim registers the same autocmd
" each `:source ~/.vimrc`. And Vim executes the same autocmds each occurring a
" Event(e.g. FileType). In one word, it's heavy.
augroup vimrc
	autocmd!
augroup END

" =========================================================================== "
" Load (Neo)Vim's configuration files
" =========================================================================== "
execute 'source' fnameescape(expand('$VIM_DIR[CONFIGS]') . 'options.vim')
execute 'source' fnameescape(expand('$VIM_DIR[CONFIGS]') . 'commands.vim')
execute 'source' fnameescape(expand('$VIM_DIR[CONFIGS]') . 'mappings.vim')
execute 'source' fnameescape(expand('$VIM_DIR[CONFIGS]') . 'theme.vim')

" =========================================================================== "
" Load plugin(s) configuration files
" =========================================================================== "
let g:loadedPluginsConfigs = {}
for s:plugin in items(g:plugs)
    " Fix the plugin names ending with filename
    let s:pluginName = split(s:plugin[0], '\.')[0]
    let s:pluginConfigPath = fnameescape(
        \ expand('$VIM_DIR[PLUGINS]') . s:pluginName . '.vim'
    \ )
    if !empty(glob(s:pluginConfigPath))
        execute 'source' s:pluginConfigPath
        let g:loadedPluginsConfigs[s:pluginName] = s:pluginConfigPath
    endif
endfor

