" =========================================================================== "
" Vim-Plug settings
" -----------------
" https://github.com/junegunn/vim-plug
" =========================================================================== "

" Install Vim-Plug if not found
let g:vim_plug_dir_path = fnameescape(g:vim_home_dir_path . '.vim/autoload/plug.vim')
if empty(glob(g:vim_plug_dir_path))
	silent !curl -fLo vim_plug_dir_path --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	augroup vimPlug
		autocmd vimPlug VimEnter * PlugInstall --sync | source '$VIMRC'
	augroup END
endif

" =========================================================================== "
" List of plugins
" =========================================================================== "
"
" Plugins will be downloaded under the specified directory
call plug#begin(fnameescape(g:vim_home_dir_path . '.vim/plugged'))

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
	"
	" Heuristically set buffer options
	" --------------------------------
	" https://github.com/tpope/vim-sleuth
	Plug 'tpope/vim-sleuth'

	" ----------------------------------------------------------------------- "
	"                                                              Theme & UI
	" ----------------------------------------------------------------------- "
	"
	" Retro groove color theme
	" ------------------------
	" https://github.com/morhetz/gruvbox
	" Plug 'morhetz/gruvbox'
	"
	" Dark colorscheme with sharper colors than gruvbox
	" -------------------------------------------------
	" https://github.com/srcery-colors/srcery-vim
	Plug 'srcery-colors/srcery-vim'
	"
	" Light theme inspired by Google's Material Design
	" ------------------------------------------------
	" https://github.com/NLKNguyen/papercolor-theme
	Plug 'NLKNguyen/papercolor-theme'
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
	"
	" Treesitter configurations and abstraction layer
	" -----------------------------------------------
	" https://github.com/nvim-treesitter/nvim-treesitter
	if has('nvim')
		" Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
	endif

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
	Plug 'dyng/ctrlsf.vim', { 'on': 'CtrlSF' }

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
	"
	" Modern performant generic finder and dispatcher
	" -----------------------------------------------
	" https://github.com/liuchengxu/vim-clap
	Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

	" ----------------------------------------------------------------------- "
	"                                                NERDTree (file explorer)
	" ----------------------------------------------------------------------- "
	"
	" File tree explorer
	" ------------------
	" https://github.com/preservim/nerdtree
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	"
	if has_key(g:plugs, 'nerdtree')
		"
		" NERDTree showing Git status
		" ---------------------------
		" https://github.com/Xuyuanp/nerdtree-git-plugin
		Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
		"
		" Extra syntax and highlight for NERDTree files
		" ---------------------------------------------
		" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
		Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
		"
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
	"															 Productivity
	" ----------------------------------------------------------------------- "
	"
	" Emmet
	" -----
	" https://github.com/mattn/emmet-vim
	Plug 'mattn/emmet-vim'
	"
	" Insert or delete brackets, parens, quotes in pair
	" -------------------------------------------------
	" https://github.com/jiangmiao/auto-pairs
	" Plug 'jiangmiao/auto-pairs'
	"
	" Auto close parentheses and repeat by dot dot dot...
	" ---------------------------------------------------
	" https://github.com/cohama/lexima.vim
	Plug 'cohama/lexima.vim'
	"
	" Multiple cursors
	" ----------------
	" https://github.com/mg979/vim-visual-multi
	Plug 'mg979/vim-visual-multi'
	"
	" Alignment
	" ---------
	" https://github.com/junegunn/vim-easy-align
	Plug 'junegunn/vim-easy-align'
	"
	" Visually select increasingly larger regions of text using the same key
	" combination
	" -----------
	" https://github.com/terryma/vim-expand-region
	Plug 'terryma/vim-expand-region'
	"
	" Reoder delimted items
	" ---------------------
	" https://github.com/machakann/vim-swap
	Plug 'machakann/vim-swap'
	"
	" Navigate and highlight matching words
	" -------------------------------------
	" https://github.com/andymass/vim-matchup
	Plug 'andymass/vim-matchup'
	"
	" Wisely add `end` in `endfunction/endif/more`
	" --------------------------------------------
	" https://github.com/tpope/vim-endwise
	Plug 'tpope/vim-endwise'
	"
	" Shows keybindings in popup
	" --------------------------
	" https://github.com/liuchengxu/vim-which-key
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
	"
	" Toggles between hybrid and absolute line numbers automatically
	" --------------------------------------------------------------
	" https://github.com/jeffkreeftmeijer/vim-numbertoggle
	Plug 'jeffkreeftmeijer/vim-numbertoggle'

	" ----------------------------------------------------------------------- "
	"													              Motions
	" ----------------------------------------------------------------------- "
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
	" Plug 'tpope/vim-unimpaired'
	"
	" Quoting/parenthesizing made simple
	"
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
	" Help stop repeating the basic movement keys
	" -------------------------------------------
	" https://github.com/takac/vim-hardtime
	Plug 'takac/vim-hardtime'
	"
	" The set of operator and textobject plugins to search/select/edit
	" sandwiched textobjects
	" ----------------------
	" https://github.com/machakann/vim-sandwich
	Plug 'machakann/vim-sandwich'

	" ----------------------------------------------------------------------- "
	"                                                               Git tools
	" ----------------------------------------------------------------------- "
	if executable('git')
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
		"
		" Asynchronously control Git repositories
		" ---------------------------------------
		" https://github.com/lambdalisue/gina.vim
		Plug 'lambdalisue/gina.vim', { 'on': 'Gina' }
		"
	endif

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
	"                                                                Snippets
	" ----------------------------------------------------------------------- "
	"
	" Snippet engine
	" NOTE: Redundant in favor of **coc-snippets**
	" --------------
	" https://github.com/SirVer/ultisnips
	" Plug 'SirVer/ultisnips'
	"
	" Default snippets
	" ----------------
	" https://github.com/honza/vim-snippets
	Plug 'honza/vim-snippets'

	" ----------------------------------------------------------------------- "
	"                                                                    Tags
	" ----------------------------------------------------------------------- "
	"
	" Tag files manager
	" -----------------
	" https://github.com/ludovicchabant/vim-gutentags
	" if executable('ctags')
	"     Plug 'ludovicchabant/vim-gutentags'
	" endif
    "
	" ----------------------------------------------------------------------- "
	"                                          LSP (Language Server Protocol)
	" ----------------------------------------------------------------------- "
	"
	" Async language server protocol plugin
	" -------------------------------------
	" https://github.com/prabirshrestha/vim-lsp
	" Plug 'prabirshrestha/vim-lsp'
	"
	if has_key(g:plugs, 'vim-lsp')
		"
		" Auto configurations for Language Server for `vim-lsp`
		" -----------------------------------------------------
		" https://github.com/mattn/vim-lsp-settings
		Plug 'mattn/vim-lsp-settings'
		"
		" Provide Language Server Protocol autocompletion source for
		" `asyncomplete.vim` and `vim-lsp`
		" --------------------------------
		" https://github.com/prabirshrestha/asyncomplete-lsp.vim
		if has_key(g:plugs, 'asyncomplete.vim')
			Plug 'prabirshrestha/asyncomplete-lsp.vim'
		endif
		"
	endif

	" ----------------------------------------------------------------------- "
	"                                                             Completions
	" ----------------------------------------------------------------------- "
	"
	" Async completion engine
	" -----------------------
	" https://github.com/prabirshrestha/asyncomplete.vim
	" Plug 'prabirshrestha/asyncomplete.vim'
	"
	if has_key(g:plugs, 'asyncomplete.vim')
		"
		" Async (normalize job control API)
		" ---------------------------------
		" https://github.com/prabirshrestha/async.vim
		Plug 'prabirshrestha/async.vim'
		"
		" ALE
		" ---
		" https://github.com/andreypopp/asyncomplete-ale.vim
		if has_key(g:plugs, 'ale')
			Plug 'andreypopp/asyncomplete-ale.vim'
		endif
		"
		" Buffer
		" ------
		" https://github.com/prabirshrestha/asyncomplete-buffer.vim
		Plug 'prabirshrestha/asyncomplete-buffer.vim'
		"
		" Dictionary (look)
		" -----------------
		" https://github.com/htlsne/asyncomplete-look
		Plug 'htlsne/asyncomplete-look'
		"
		" Emmet
		" -----
		" https://github.com/prabirshrestha/asyncomplete-emmet.vim
		if has_key(g:plugs, 'emmet-vim')
			Plug 'prabirshrestha/asyncomplete-emmet.vim'
		endif
		"
		" Emoji
		" -----
		" https://github.com/prabirshrestha/asyncomplete-emoji.vim
		Plug 'prabirshrestha/asyncomplete-emoji.vim'
		"
		" Filenames / directories
		" -----------------------
		" https://github.com/prabirshrestha/asyncomplete-file.vim
		Plug 'prabirshrestha/asyncomplete-file.vim'
		"
		" Git commit message
		" ------------------
		" https://github.com/laixintao/asyncomplete-gitcommit
		if executable('git')
			Plug 'laixintao/asyncomplete-gitcommit'
		endif
		"
		" UltiSnips
		" ---------
		" https://github.com/prabirshrestha/asyncomplete-ultisnips.vim
		Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
		"
		" GutenTags
		" ---------
		" Plug 'prabirshrestha/asyncomplete-tags.vim'
		if has_key(g:plugs, 'vim-gutentags')
			Plug 'prabirshrestha/asyncomplete-ntags.vim'
		endif
		"
	endif
	"
	" Conquer of Completion - intellisense engine with full LSP support as
	" VSCode
	" ------
	" https://github.com/neoclide/coc.nvim
	Plug 'neoclide/coc.nvim', { 'branch': 'release' }
	"
	if has_key(g:plugs, 'coc.nvim')
		"
		" Integration with `fzf-vim`
		" -------------------------
		" https://github.com/antoinemadec/coc-fzf
		Plug 'antoinemadec/coc-fzf'
		"
		" VimL completion source
		" ----------------------
		"https://github.com/neoclide/coc-neco
		Plug 'neoclide/coc-neco' | Plug 'Shougo/neco-vim'
		"
	endif

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
	"
	" A markdown preview with `glow`
	" ------------------------------
	" https://github.com/npxbr/glow.nvim
	if executable('glow')
		Plug 'npxbr/glow.nvim', { 'on': 'Glow' }
	endif

	" List ends here and, plugins become visible to (Neo)Vim after this call
call plug#end()

" =========================================================================== "
" Plugins helpers
" =========================================================================== "
"
" If defined autocmds are without a group, Vim registers the same autocmd
" each `:source ~/.vimrc`. And Vim executes the same autocmds each occurring a
" Event(e.g. FileType). In one word, it's heavy.
augroup vimrc
	autocmd!
augroup END

" Check if plugin is installed
let g:plugin = { 'plugs': get(g:, 'plugs', {})  }
function! g:plugin.is_installed(pluginName) abort
	return has_key(l:self.plugs, a:pluginName)
		\ ? isdirectory(l:self.plugs[a:pluginName].dir)
		\ : 0
endfunction


" =========================================================================== "
" Load plugin(s) configuration files
" =========================================================================== "
let g:vim_plugins_config_dir_path = expand('$VIM_DIR[PLUGINS]')
let g:loaded_plugins_configs = {}
for s:plugin in items(g:plugs)
	if g:plugin.is_installed(s:plugin[0])
		" Remove the `.vim` from the plugin names
		let s:plugin_name = split(s:plugin[0], '\.')[0]
		let s:plugin_config_file_path = fnameescape(
			\ g:vim_plugins_config_dir_path . s:plugin_name . '.vim'
		\ )
		if !empty(glob(s:plugin_config_file_path))
			execute 'source' s:plugin_config_file_path
			let g:loaded_plugins_configs[s:plugin_name] = s:plugin_config_file_path
		endif
	endif
endfor
