" ==============================================================================
" Vim-Plug settings
" -----------------
" https://github.com/junegunn/vim-plug
" ==============================================================================

" Install Vim-Plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory
call plug#begin('~/.vim/plugged')
" Declare the list of plugins

	" Essentials
	" ----------
	" Vim defaults everyone can agree on
	" https://github.com/tpope/vim-sensible
	Plug 'tpope/vim-sensible'
	"
	" EditorConfig https://github.com/editorconfig/editorconfig-vim
	Plug 'editorconfig/editorconfig-vim'

	" Navigation
	" ----------
	" Display tags in a window, ordered by scope
	" https://github.com/preservim/tagbar
	Plug 'majutsushi/tagbar'
	"
	" A tree explorer
	" https://github.com/preservim/nerdtree
	Plug 'preservim/nerdtree'
	"
	" A solid language pack
	" https://github.com/sheerun/vim-polyglot
	Plug 'sheerun/vim-polyglot'
	"
	" Fuzzy file, buffer, mru, tag, etc finder
	" https://github.com/ctrlpvim/ctrlp.vim
	Plug 'ctrlpvim/ctrlp.vim'
	"
	" Add fzf and fzf-based commands
	" https://github.com/junegunn/fzf.vim
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	"
	" Physics-based smooth scrolling
	" https://github.com/yuttie/comfortable-motion.vim
	Plug 'yuttie/comfortable-motion.vim'

	" Motion & Productivity
	" ---------------------
	" Multiple cursors
	" https://github.com/mg979/vim-visual-multi
	Plug 'mg979/vim-visual-multi'
	"
	" Motions on speed
	" https://github.com/easymotion/vim-easymotion
	Plug 'easymotion/vim-easymotion'
	"
	" Jump to any location specified by two characters
	" https://github.com/justinmk/vim-sneak
	Plug 'justinmk/vim-sneak'
	"
	" Enable repeating supported plugin maps with `.`
	" https://github.com/tpope/vim-repeat
	Plug 'tpope/vim-repeat'
	"
	" Pairs of handy bracket mappings
	" https://github.com/tpope/vim-unimpaired
	Plug 'tpope/vim-unimpaired'
	"
	" Quoting/parenthesizing made simple
	" https://github.com/tpope/vim-surround
	Plug 'tpope/vim-surround'
	"
	" Intensely nerdy commenting powers
	" https://github.com/scrooloose/nerdcommenter
	Plug 'scrooloose/nerdcommenter'
	"
	" Provide additional text objects
	" https://github.com/wellle/targets.vim
	Plug 'wellle/targets.vim'
	"
	" Insert or delete brackets, parens, quotes in pair
	" https://github.com/jiangmiao/auto-pairs
	Plug 'jiangmiao/auto-pairs'
	"
	" Alignment
	" https://github.com/junegunn/vim-easy-align
	Plug 'junegunn/vim-easy-align'
	"
	" Emmet
	" https://github.com/mattn/emmet-vim
	Plug 'mattn/emmet-vim'

	" Completion
	" ----------
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

	" Theme & UI
	" ----------
	" Dark color theme
	" https://github.com/joshdick/onedark.vim
	" Plug 'joshdick/onedark.vim'
	"
	" Low contrast theme
	" https://github.com/junegunn/seoul256.vim
	Plug 'junegunn/seoul256.vim'
	"
	" A light and configurable statusline/tabline
	" https://github.com/itchyny/lightline.vim
	Plug 'itchyny/lightline.vim'
	"
	" File type icons
	" https://github.com/ryanoasis/vim-devicons
	Plug 'ryanoasis/vim-devicons'
	"
	" Distraction-free writing
	" https://github.com/junegunn/goyo.vim
	Plug 'junegunn/goyo.vim'

	" Syntax
	" -------------------
	" Rainbow parentheses/brackets
	" https://github.com/luochen1990/rainbow
	Plug 'luochen1990/rainbow'
	"
	" Visually displaying indent levels in code
	" https://github.com/nathanaelkane/vim-indent-guides
	" Plug 'nathanaelkane/vim-indent-guides'
	"
	" Display the indention levels with thin vertical lines
	" https://github.com/Yggdroot/indentLine
	" Plug 'Yggdroot/indentLine'
	"
	" Make the yanked region apparent
	" https://github.com/machakann/vim-highlightedyank
	Plug 'machakann/vim-highlightedyank'
	"
	" Hyperfocus-writing
	" https://github.com/junegunn/limelight.vim
	Plug 'junegunn/limelight.vim'
	"
	" Extra syntax and highlight for NERDTree files
	" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight
	" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	"
	" Syntax highlighting plugin for JSONC files
	" https://github.com/kevinoid/vim-jsonc
	Plug 'kevinoid/vim-jsonc'
	"
	" Other
	" -----
	" The interactive scratchpad for hackers
	" https://github.com/metakirby5/codi.vim
	Plug 'metakirby5/codi.vim'

" List ends here and, plugins become visible to Vim after this call
call plug#end()

" =============================================================================
" Vim options
" -----------
" http://vimdoc.sourceforge.net/htmldoc/help.html
" =============================================================================

" Searching
" ---------
" Highlight matches as you type
set incsearch
" Highlight matches once a search is complete
set hlsearch
" Bind turning off highlighting to hotkey (":noh" alias)
nnoremap <Leader><Space> :nohlsearch<CR>

" Invisible characters & wrapping
" -------------------------------
" Disable line-wrap
set nowrap
"
" Show invisible characters
set list
set listchars=eol:¬,tab:┆\ ,trail:·,precedes:«,extends:»,space:·,nbsp:␣

" Navigation
" ----------
" Visual indicator to show where your cursor is (line and column)
set cursorline
set cursorcolumn
"
" Visually highlight the preferred line length (column on the right)
set colorcolumn=80
"
" Show line number on the left
set number
"
" Set scroll offset
set scrolloff=8

" Indentation
" -----------
" Don't convert TAB to spaces
set noexpandtab
" The width of the TAB
set tabstop=4
" Make TAB working in the middle of line (text)
set softtabstop=4
" Indent width
set shiftwidth=4

" Backup & swap
" -------------
" Disable backups and swap files
set nobackup
set nowritebackup
set noswapfile

" Folding
" -------
" Enable folding
set foldmethod=manual
set foldlevel=99

" Other
" -----
" User-defined commands must start with a capital letter
"
command! RefreshConfig source $MYVIMRC
command! EditConfig edit $MYVIMRC
"
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
set updatetime=300

" =============================================================================
" Plugins settings
" =============================================================================

" One Dark theme settings
" -----------------------
" https://github.com/joshdick/onedark.vim
"
" Expand colors in terminal using GUI
if (has("termguicolors"))
	set termguicolors
endif
"
" Enable syntax highlight
syntax enable
"
" Set theme
colorscheme seoul256
"
" Bind hotkey to toggle dark/light theme
map <F12> :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Lightline (bottom bar) settings
" ----------------------
" https://github.com/itchyny/lightline.vim
"
" Set theme for this bar
" let g:lightline = { 'colorscheme': 'onedark' }
" Disable -- INSERT -- as is unnecessary anymore because the mode information
" is displayed in the statusline
set noshowmode

" NERDTree settings
" -----------------
" https://github.com/preservim/nerdtree
"
" Binding toggle to `Ctrl + n`
map <C-n> :NERDTreeToggle<CR>
"
" If more than one window and previous buffer was NERDTree, go back to it.
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
" Avoid crashes when calling Vim-Plug functions while the cursor is on the
" NERDTree window
let g:plug_window = 'noautocmd vertical topleft new'
"
" Move NERDTree to the right side
let g:NERDTreeWinPos = "right"
"
" Open NERDTree automatically when Vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | wincmd p | ene | exe 'NERDTree' argv()[0] | endif
" Close Vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Rainbow bracket/parentheses settings
" ------------------------------------
" https://github.com/luochen1990/rainbow
let g:rainbow_active = 1

" Indent Guides settings
" ----------------------
" https://github.com/nathanaelkane/vim-indent-guides
"
" Enable guides on Vim startup
let g:indent_guides_enable_on_vim_startup = 1
"
" Start indent guides from indent number...
let g:indent_guides_start_level = 1
"
" Size of the indent guide (block-width)
let g:indent_guides_guide_size = 1

" NERD Commenter settings
" -----------------------
" https://github.com/preservim/nerdcommenter
"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
"
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
"
" Align line-wise comment delimiters flush left
" instead of following code indentation
let g:NERDDefaultAlign = 'left'
"
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
"
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
"
" Allow commenting and inverting empty
" lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
"
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
"
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Tagbar settings
" ---------------
" https://github.com/preservim/tagbar
"
" Bind toggle to hotkey
nmap <F8> :TagbarToggle<CR>

" Vim Easy Align settings
" -----------------------
" https://github.com/junegunn/vim-easy-align
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"

" Limelight settings
" ------------------
" https://github.com/junegunn/limelight.vim
"
" Bind hotkey for toggling Limelight on and off
map <F9> :Limelight!!<CR>
"
" Bind hotkey for invoking Limelight for a visual range
" (NORMAL and VISUAL mode)
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)
"
" Set the conceal level
let g:limelight_default_coefficient = 0.8

" Goyo settings
" -------------
" https://github.com/junegunn/goyo.vim
"
" Bind toggle Goyo to hotkey
map <F10> :Goyo<CR>
"
" Integrate with Limelight plugin
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Vim Emoji settings
" ------------------
" https://github.com/junegunn/vim-emoji
"
" Enable emoji completion (Press Ctrl + x then Ctrl + u)
set completefunc=emoji#complete

" YouCompleteMe (YCM) settings
" ----------------------------
" https://github.com/ycm-core/YouCompleteMe
"
" Bind to hotkey(s) selected completion
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'

" UltiSnips settings
" ------------------
" https://github.com/SirVer/ultisnips
"
" Trigger configuration
" let g:UltiSnipsExpandTrigger="<c-j>"
" let g:ultisnipsjumpforwardtrigger="<c-b>"
" let g:ultisnipsjumpbackwardtrigger="<c-z>"

" =============================================================================
" CoC (Conquer of Completion) settings
" ------------------------------------
" https://github.com/neoclide/coc.nvim
" =============================================================================
"
" Configure snippet completion to work similarly to VSCode
inoremap <silent><expr> <TAB>
	\ pumvisible()
		\ ? coc#_select_confirm()
		\ : coc#expandableOrJumpable()
			\ ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>"
			\ : <SID>check_back_space()
				\ ? "\<TAB>"
				\ : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
let g:coc_snippet_next = '<tab>'
"
" Global extensions
" -----------------
" https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions#implemented-coc-extensions
let g:coc_global_extensions = [
	\ 'coc-marketplace',
	\ 'coc-tabnine',
	\ 'coc-snippets',
	\ 'coc-git'
\ ]
"
" TextEdit might fail if hidden is not set
set hidden
"
" Some servers have issues with backup files, see #649.
" set nobackup
" set nowritebackup
"
" Give more space for displaying messages.
set cmdheight=2
"
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
"
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
" Recently vim can merge signcolumn and number column into one
	set signcolumn=number
else
	set signcolumn=yes
endif
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
	autocmd!
	" Setup formatexpr specified filetype(s).
	autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	" Update signature help on jump placeholder.
	autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" NOTE:  coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ?  coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ?  coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ?  "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ?  "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
	vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ?  coc#float#nvim_scroll(1, 1) : "\<C-f>"
	vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ?  coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>"

" ALE (Asynchronous Lint Engine) settings
" ---------------------------------------
" https://github.com/dense-analysis/ale

