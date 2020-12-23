" =========================================================================== "
" Vim-Plug settings
" -----------------
" https://github.com/junegunn/vim-plug
" =========================================================================== "

" Install Vim-Plug if not found
let g:vim_plug_dir_path = fnameescape(
	\ g:vim_home_dirPath . '.vim/autoload/plug.vim'
\ )
if empty(glob(g:vim_plug_dir_path))
	silent !curl -fLo vim_plug_dir_path --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	augroup vimPlug
		autocmd vimPlug VimEnter * PlugInstall --sync | source '$VIMRC'
	augroup END
endif

" =========================================================================== "
" Helpers for plugins
" =========================================================================== "

let g:plugins = {
	\ 'configurations_dirPath': expand('$VIM_DIR[PLUGINS]'),
	\ 'installed': [],
	\ 'configurations_loaded': [],
	\ 'postponed': []
\ }

" Add loaded configurations of plugins
function! g:plugins.add_installed(pluginName)
	if has_key(g:plugs, a:pluginName) && isdirectory(g:plugs[a:pluginName].dir)
		call add(l:self.installed, a:pluginName)
	endif
endfunction

" Check if plugin is installed
function! g:plugins.is_installed(pluginName)
	return index(l:self.installed, a:pluginName) != -1
endfunction

" Get configuration path for plugin
function! g:plugins.get_configurationFilePath(pluginName)
	return fnameescape(l:self.configurations_dirPath . a:pluginName . '.vim')
endfunction

" Load plugin's configuration file
function! g:plugins.load_configurationFile(pluginName)
	let s:config_filePath = l:self.get_configurationFilePath(a:pluginName)
	if !empty(glob(s:config_filePath))
		execute 'source' s:config_filePath
		call g:plugins.add_configurationLoaded(a:pluginName)
	endif
endfunction

" Add loaded configurations of plugins
function! g:plugins.add_configurationLoaded(pluginName)
	if l:self.is_installed(a:pluginName)
		call add(l:self.configurations_loaded, a:pluginName)
	endif
endfunction

" Check if plugin's configuration file is loaded
function! g:plugins.is_configurationLoaded(pluginName)
	return index(l:self.configurations_loaded, a:pluginName) != -1
endfunction

" Add plugin to postponed list - to be loaded at the end of queue
function! g:plugins.add_postponed(pluginName)
	call add(l:self.postponed, a:pluginName)
endfunction

" Change the order, move the plugin to be installed/loaded at the end
function! g:plugins.postpone_loading()
	for s:pluginName in l:self.postponed
		call filter(g:plugs_order, { index, value -> value !=# s:pluginName })
		call add(g:plugs_order, s:pluginName)
	endfor
endfunction

" Reload plugin's configuration file
function! g:plugins.reload_configuration(pluginName)
	execute 'source ' . l:self.get_configurationFilePath(a:pluginName)
	echomsg 'Finished reloading configuration file for plugin: "'
		\ . a:pluginName
		\ . '"!'
endfunction

" =========================================================================== "
" List of plugins
" =========================================================================== "

" Plugins will be downloaded under the specified directory
call plug#begin(fnameescape(g:vim_home_dirPath . '.vim/plugged'))

	" ----------------------------------------------------------------------- "
	"                                                              Essentials
	" ----------------------------------------------------------------------- "

		" Vim defaults everyone can agree on
		" ----------------------------------
		" https://github.com/tpope/vim-sensible
		Plug 'tpope/vim-sensible', { 'as': 'sensible' }

		" EditorConfig
		" ------------
		" https://github.com/editorconfig/editorconfig-vim
		Plug 'editorconfig/editorconfig-vim', {
			\ 'as': 'editorconfig'
		\ }

		" Heuristically set buffer options
		" --------------------------------
		" https://github.com/tpope/vim-sleuth
		Plug 'tpope/vim-sleuth', { 'as': 'sleuth' }

		" Shows key bidings (mappings) in a popup, is like a cheatsheet
		" -------------------------------------------------------------
		" https://github.com/liuchengxu/vim-which-key
		" NOTE: At the moment it shows key binded to <Leader> and <LocalLeader>
		Plug 'liuchengxu/vim-which-key', {
			\ 'as': 'which-key',
			\ 'on': ['WhichKey', 'WhichKey!']
		\ }
		call g:plugins.add_postponed('which-key')

	" ----------------------------------------------------------------------- "
	"                                                              Theme & UI
	" ----------------------------------------------------------------------- "

		" Retro groove color theme
		" ------------------------
		" https://github.com/morhetz/gruvbox
		" Plug 'morhetz/gruvbox'

		" Dark colorscheme with sharper colors than gruvbox
		" -------------------------------------------------
		" https://github.com/srcery-colors/srcery-vim
		Plug 'srcery-colors/srcery-vim', { 'as': 'theme-srcery' }

		" Light theme inspired by Google's Material Design
		" ------------------------------------------------
		" https://github.com/NLKNguyen/papercolor-theme
		Plug 'NLKNguyen/papercolor-theme', { 'as': 'theme-papercolor' }

		" File type icons
		" ---------------
		" https://github.com/ryanoasis/vim-devicons
		Plug 'ryanoasis/vim-devicons', { 'as': 'devicons' }

		" A light and configurable statusline/tabline
		" -------------------------------------------
		" https://github.com/itchyny/lightline.vim
		Plug 'itchyny/lightline.vim', { 'as': 'lightline' }
		call g:plugins.add_postponed('lightline')

		" Hyperfocus-writing
		" ------------------
		" https://github.com/junegunn/limelight.vim
		Plug 'junegunn/limelight.vim', {
			\ 'as': 'limelight',
			\ 'on': 'Limelight'
		\ }

		" Distraction-free writing
		" ------------------------
		" https://github.com/junegunn/goyo.vim
		Plug 'junegunn/goyo.vim', {
			\ 'as': 'goyo',
			\ 'on': 'Goyo'
		\ }

	" ----------------------------------------------------------------------- "
	"                                                                  Syntax
	" ----------------------------------------------------------------------- "

		" A solid language pack
		" ---------------------
		" https://github.com/sheerun/vim-polyglot
		Plug 'sheerun/vim-polyglot', { 'as': 'polyglot' }

		" Speed up (Neo)Vim by updating folds only when called
		" ----------------------------------------------------
		" https://github.com/Konfekt/FastFold
		Plug 'Konfekt/FastFold', { 'as': 'fastfold' }

		" Rainbow parentheses/brackets
		" ----------------------------
		" https://github.com/luochen1990/rainbow
		Plug 'luochen1990/rainbow'
		call g:plugins.add_postponed('rainbow')

		" Asynchronously displaying the colours in the file
		" -------------------------------------------------
		" https://github.com/RRethy/vim-hexokinase
		Plug 'RRethy/vim-hexokinase', {
			\ 'as': 'hexokinase',
			\ 'do': 'make hexokinase'
		\ }

		" Make the yanked region apparent
		" -------------------------------
		" https://github.com/machakann/vim-highlightedyank
		Plug 'machakann/vim-highlightedyank', { 'as': 'highlightedyank' }

		" Syntax highlighting for JSONC files
		" -----------------------------------
		" https://github.com/kevinoid/vim-jsonc
		Plug 'kevinoid/vim-jsonc', {
			\ 'as': 'jsonc',
			\ 'for': ['jsonc', 'json']
		\ }

		" Range, pattern and substitute preview
		" -------------------------------------
		" https://github.com/markonm/traces.vim
		Plug 'markonm/traces.vim'

		" Treesitter configurations and abstraction layer
		" -----------------------------------------------
		" https://github.com/nvim-treesitter/nvim-treesitter
		if has('nvim')
			" Plug 'nvim-treesitter/nvim-treesitter', { 'do': 'TSUpdate' }
		endif

		" Visually displaying indent levels in code
		" -----------------------------------------
		" https://github.com/nathanaelkane/vim-indent-guides
		Plug 'nathanaelkane/vim-indent-guides', {
			\ 'as': 'indent-guides',
			\ 'on': 'IndentGuidesToggle'
		\ }

		" Syntax highlighting, matching rules and mappings for the original
		" Markdown and extensions
		" -----------------------
		" https://github.com/plasticboy/vim-markdown
		Plug 'plasticboy/vim-markdown', { 'as': 'markdown' }

	" ----------------------------------------------------------------------- "
	"                                                               Searchers
	" ----------------------------------------------------------------------- "

		" Plugin for the the Perl module `ack` or `ag`
		" ----------------------------------
		" https://github.com/mileszs/ack.vim
		" NOTE: Outdated, 'CtrlSF' is doing better job
		" Plug 'mileszs/ack.vim'

		" An `ack/ag/pt/rg` powered code search and view tool
		" ---------------------------------------------------
		" https://github.com/dyng/ctrlsf.vim
		Plug 'dyng/ctrlsf.vim', { 'as': 'ctrlsf' }

	" ----------------------------------------------------------------------- "
	"                                                     Interactive filters
	" ----------------------------------------------------------------------- "

		" Add `fzf` and fzf-based commands
		" --------------------------------
		" https://github.com/junegunn/fzf.vim
		Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
		Plug 'junegunn/fzf.vim', { 'as': 'fzf-integration' }

		" Fuzzy file, buffer, mru, tag, etc finder
		" ----------------------------------------
		" https://github.com/ctrlpvim/ctrlp.vim
		" NOTE: It's obsolete, `fzf.vim` is never
		" Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }

		" Efficient fuzzy finder that helps to locate files, buffers, mru, etc.
		" ---------------------------------------------------------------------
		" https://github.com/Yggdroot/LeaderF
		" NOTE: Unfriendly for me
		" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

		" Modern performant generic finder and dispatcher
		" -----------------------------------------------
		" https://github.com/liuchengxu/vim-clap
		" NOTE: Frigging slow, still in BETA
		" Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

	" ----------------------------------------------------------------------- "
	"                                                NERDTree (file explorer)
	" ----------------------------------------------------------------------- "

		" File tree explorer
		" ------------------
		" https://github.com/preservim/nerdtree
		Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

		if has_key(g:plugs, 'nerdtree')

			" NERDTree showing Git status
			" ---------------------------
			" https://github.com/Xuyuanp/nerdtree-git-plugin
			Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

			" Extra syntax and highlight for NERDTree files
			" ---------------------------------------------
			" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
			Plug 'tiagofumo/vim-nerdtree-syntax-highlight', {
				\ 'as': 'nerdtree-syntax-highlight',
				\ 'on': 'NERDTreeToggle'
			\ }

		endif

	" ----------------------------------------------------------------------- "
	"                                                              Navigating
	" ----------------------------------------------------------------------- "

		" Viewer & Finder for LSP (Language Server Protocol) symbols and tags
		" -------------------------------------------------------------------
		" https://github.com/liuchengxu/vista.vim
		Plug 'liuchengxu/vista.vim', { 'as': 'vista' }

		" Graph Vim undo tree in style
		" ----------------------------
		" https://github.com/simnalamburt/vim-mundo
		Plug 'simnalamburt/mundo.vim', {
			\ 'as': 'mundo',
			\ 'on': 'MundoToggle'
		\ }

	" ----------------------------------------------------------------------- "
	"															 Productivity
	" ----------------------------------------------------------------------- "

		" Emmet
		" -----
		" https://github.com/mattn/emmet-vim
		Plug 'mattn/emmet-vim', { 'as': 'emmet' }

		" Insert or delete brackets, parens, quotes in pair
		" -------------------------------------------------
		" https://github.com/jiangmiao/auto-pairs
		" NOTE: Obsolete, replaced with 'lexima', which seems to be more modern
		" Plug 'jiangmiao/auto-pairs'

		" Auto close parentheses and repeat by dot dot dot...
		" ---------------------------------------------------
		" https://github.com/cohama/lexima.vim
		Plug 'cohama/lexima.vim', { 'as': 'lexima' }

		" Multiple cursors
		" ----------------
		" https://github.com/mg979/vim-visual-multi
		Plug 'mg979/vim-visual-multi', { 'as': 'visual-multi' }

		" Alignment
		" ---------
		" https://github.com/junegunn/vim-easy-align
		Plug 'junegunn/vim-easy-align', { 'as': 'easy-align' }

		" Visually select increasingly larger regions of text using the same key
		" combination
		" -----------
		" https://github.com/terryma/vim-expand-region
		Plug 'terryma/vim-expand-region', { 'as': 'expand-region' }

		" Reoder delimted items
		" ---------------------
		" https://github.com/machakann/vim-swap
		Plug 'machakann/vim-swap', { 'as': 'swap' }

		" Navigate and highlight matching words
		" -------------------------------------
		" https://github.com/andymass/vim-matchup
		Plug 'andymass/vim-matchup', { 'as': 'matchup' }

		" Wisely add `end` in `endfunction/endif/more`
		" --------------------------------------------
		" https://github.com/tpope/vim-endwise
		Plug 'tpope/vim-endwise', { 'as': 'endwise' }

		" Toggles between hybrid and absolute line numbers automatically
		" --------------------------------------------------------------
		" https://github.com/jeffkreeftmeijer/vim-numbertoggle
		Plug 'jeffkreeftmeijer/vim-numbertoggle', { 'as': 'numbertoggle' }

		" Help stop repeating the basic movement keys
		" -------------------------------------------
		" https://github.com/takac/vim-hardtime
		Plug 'takac/vim-hardtime', { 'as': 'hardtime' }

		" Configurable, flexible, intuitive text aligning
		" -----------------------------------------------
		" https://github.com/godlygeek/tabular
		Plug 'godlygeek/tabular'

	" ----------------------------------------------------------------------- "
	"													              Motions
	" ----------------------------------------------------------------------- "

		" Motions on speed
		" ----------------
		" https://github.com/easymotion/vim-easymotion
		Plug 'easymotion/vim-easymotion', { 'as': 'easymotion' }

		" Jump to any location specified by two characters
		" ------------------------------------------------
		" https://github.com/justinmk/vim-sneak
		Plug 'justinmk/vim-sneak', { 'as': 'sneak' }

		" Enable repeating supported plugin maps with `.`
		" -----------------------------------------------
		" https://github.com/tpope/vim-repeat
		Plug 'tpope/vim-repeat', { 'as': 'repeat' }

		" Pairs of handy bracket mappings
		" -------------------------------
		" https://github.com/tpope/vim-unimpaired
		" Plug 'tpope/vim-unimpaired'

		" Quoting/parenthesizing made simple
		" ----------------------------------
		" https://github.com/tpope/vim-surround
		Plug 'tpope/vim-surround', { 'as': 'surround' }

		" Intensely nerdy commenting powers
		" ---------------------------------
		" https://github.com/scrooloose/nerdcommenter
		Plug 'scrooloose/nerdcommenter'

		" Provide additional text objects
		" -------------------------------
		" https://github.com/wellle/targets.vim
		Plug 'wellle/targets.vim', { 'as': 'targets' }

		" The set of operator and textobject plugins to search/select/edit
		" sandwiched textobjects
		" ----------------------
		" https://github.com/machakann/vim-sandwich
		Plug 'machakann/vim-sandwich', { 'as': 'sandwich' }

	" ----------------------------------------------------------------------- "
	"                                                               Git tools
	" ----------------------------------------------------------------------- "

		if executable('git')

			" Git wrapper
			" -----------
			" https://github.com/tpope/vim-fugitive
			Plug 'tpope/vim-fugitive', { 'as': 'fugitive' }

			" Shows git diff markers in the sign column and stages/previews/etc
			" -----------------------------------------------------------------
			" https://github.com/airblade/vim-gitgutter
			Plug 'airblade/vim-gitgutter', { 'as': 'gitgutter' }

			" Asynchronously control Git repositories
			" ---------------------------------------
			" https://github.com/lambdalisue/gina.vim
			Plug 'lambdalisue/gina.vim', {
				\ 'as': 'gina',
				\ 'on': 'Gina'
			\ }

		else
			echoerr 'Git not found, hence some plugins wont be installed!'
		endif

	" ----------------------------------------------------------------------- "
	"                                                                 Linters
	" ----------------------------------------------------------------------- "

		" Check syntax in Vim asynchronously and fix files, with Language Server
		" Protocol (LSP) support
		" ----------------------
		" https://github.com/dense-analysis/ale
		Plug 'dense-analysis/ale'

		" ALE indicator for the Lightline Vim plugin
		" ------------------------------------------
		" https://github.com/maximbaz/lightline-ale
		if has_key(g:plugs, 'ale') && has_key(g:plugs, 'lightline')
			Plug 'maximbaz/lightline-ale'
		endif

	" ----------------------------------------------------------------------- "
	"                                                                Snippets
	" ----------------------------------------------------------------------- "

		" Snippet engine
		" NOTE: Redundant in favor of **coc-snippets**
		" --------------
		" https://github.com/SirVer/ultisnips
		" Plug 'SirVer/ultisnips'

		" Default snippets
		" ----------------
		" https://github.com/honza/vim-snippets
		Plug 'honza/vim-snippets', { 'as': 'snippets' }

	" ----------------------------------------------------------------------- "
	"                                                                    Tags
	" ----------------------------------------------------------------------- "

		" Tag files manager
		" -----------------
		" https://github.com/ludovicchabant/vim-gutentags
		" if executable('ctags')
		"     Plug 'ludovicchabant/vim-gutentags'
		" endif

	" ----------------------------------------------------------------------- "
	"                                          LSP (Language Server Protocol)
	" ----------------------------------------------------------------------- "

		" Async language server protocol plugin
		" -------------------------------------
		" https://github.com/prabirshrestha/vim-lsp
		" Plug 'prabirshrestha/vim-lsp'

		if has_key(g:plugs, 'vim-lsp')

			" Auto configurations for Language Server for `vim-lsp`
			" -----------------------------------------------------
			" https://github.com/mattn/vim-lsp-settings
			Plug 'mattn/vim-lsp-settings'

			" Provide Language Server Protocol autocompletion source for
			" `asyncomplete.vim` and `vim-lsp`
			" --------------------------------
			" https://github.com/prabirshrestha/asyncomplete-lsp.vim
			if has_key(g:plugs, 'asyncomplete.vim')
				Plug 'prabirshrestha/asyncomplete-lsp.vim'
			endif

		endif

	" ----------------------------------------------------------------------- "
	"                                                             Completions
	" ----------------------------------------------------------------------- "

		" Async completion engine
		" -----------------------
		" https://github.com/prabirshrestha/asyncomplete.vim
		" Plug 'prabirshrestha/asyncomplete.vim'

		if has_key(g:plugs, 'asyncomplete.vim')

			" Async (normalize job control API)
			" ---------------------------------
			" https://github.com/prabirshrestha/async.vim
			Plug 'prabirshrestha/async.vim'

			" ALE
			" ---
			" https://github.com/andreypopp/asyncomplete-ale.vim
			if has_key(g:plugs, 'ale')
				Plug 'andreypopp/asyncomplete-ale.vim'
			endif

			" Buffer
			" ------
			" https://github.com/prabirshrestha/asyncomplete-buffer.vim
			Plug 'prabirshrestha/asyncomplete-buffer.vim'

			" Dictionary (look)
			" -----------------
			" https://github.com/htlsne/asyncomplete-look
			Plug 'htlsne/asyncomplete-look'

			" Emmet
			" -----
			" https://github.com/prabirshrestha/asyncomplete-emmet.vim
			if has_key(g:plugs, 'emmet')
				Plug 'prabirshrestha/asyncomplete-emmet.vim'
			endif

			" Emoji
			" -----
			" https://github.com/prabirshrestha/asyncomplete-emoji.vim
			Plug 'prabirshrestha/asyncomplete-emoji.vim'

			" Filenames / directories
			" -----------------------
			" https://github.com/prabirshrestha/asyncomplete-file.vim
			Plug 'prabirshrestha/asyncomplete-file.vim'

			" Git commit message
			" ------------------
			" https://github.com/laixintao/asyncomplete-gitcommit
			if executable('git')
				Plug 'laixintao/asyncomplete-gitcommit'
			endif

			" UltiSnips
			" ---------
			" https://github.com/prabirshrestha/asyncomplete-ultisnips.vim
			Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

			" GutenTags
			" ---------
			" Plug 'prabirshrestha/asyncomplete-tags.vim'
			if has_key(g:plugs, 'vim-gutentags')
				Plug 'prabirshrestha/asyncomplete-ntags.vim'
			endif

		endif

		" Conquer of Completion - intellisense engine with full LSP support as
		" VSCode
		" ------
		" https://github.com/neoclide/coc.nvim
		if executable('node')
			Plug 'neoclide/coc.nvim', {
				\ 'as':     'coc',
				\ 'branch': 'release'
				\ }
		else
			echoerr 'Node.JS not found, hence some plugins will not be installed!'
		endif

		if has_key(g:plugs, 'coc')

			" Integration with `fzf-vim`
			" -------------------------
			" https://github.com/antoinemadec/coc-fzf
			Plug 'antoinemadec/coc-fzf'

			" VimL completion source
			" ----------------------
			"https://github.com/neoclide/coc-neco
			Plug 'neoclide/coc-neco' | Plug 'Shougo/neco-vim', { 'as': 'neco' }

		endif

	" ----------------------------------------------------------------------- "
	"                                                                   Other
	" ----------------------------------------------------------------------- "

		" Physics-based smooth scrolling
		" ------------------------------
		" https://github.com/yuttie/comfortable-motion.vim
		Plug 'yuttie/comfortable-motion.vim'

		" The interactive scratchpad for hackers
		" --------------------------------------
		" https://github.com/metakirby5/codi.vim
		Plug 'metakirby5/codi.vim', {
			\ 'as': 'codi',
			\ 'on': 'Codi'
		\ }

		" Automatic Window Resizing Plugin
		" --------------------------------
		" https://github.com/camspiers/lens.vim
		" Plug 'camspiers/animate.vim'
		" Plug 'camspiers/lens.vim'

		" Helpers for UNIX
		" ----------------
		" https://github.com/tpope/vim-eunuch
		Plug 'tpope/vim-eunuch', { 'as': 'eunuch' }

		" The fancy start screen
		" ----------------------
		" https://github.com/mhinz/vim-startify
		Plug 'mhinz/vim-startify', { 'as': 'startify' }

		" A markdown preview with `glow`
		" ------------------------------
		" https://github.com/npxbr/glow.nvim
		if executable('glow')
			Plug 'npxbr/glow.nvim', { 'as': 'glow', 'on': 'Glow' }
		endif

" Change plug_order with postponed plugins
call g:plugins.postpone_loading()

" List ends here and, plugins become visible to (Neo)Vim after this call
call plug#end()

" =========================================================================== "
" Load plugin(s) configuration files
" =========================================================================== "
for s:pluginName in g:plugs_order
	call g:plugins.add_installed(s:pluginName)
	call g:plugins.load_configurationFile(s:pluginName)
endfor

