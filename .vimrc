" ?
filetype plugin indent on

" Set encoding for all files
set encoding=UTF-8

" Disable line-wrap
set nowrap

"" Hightlight where your cursor is (line and column)
set cursorline
set cursorcolumn
set colorcolumn=80

" ==============
" Paste settings
" ==============
" Use the clipboards of VIM and Windows
set clipboard+=unnamed
" Paste from a Windows or from VIM
" set paste
" Visual selection automatically copied to the clipboard
set go+=a

" ====================
" Indentation settings
" ====================
" The width of the TAB
set tabstop=2
" Indent width
set shiftwidth=2
" Number of columns for a TAB
set softtabstop=2
" Expand TAB to spaces
set expandtab
" Show whitespaces '>'
set list
" Show line's number on the left
set number
" ======================
" Indent Guides settings
" ======================
" Enable guides on VIM startup
let g:indent_guides_enable_on_vim_startup = 1
" Start indent guides from indenr number...
let g:indent_guides_start_level = 1
" Size of the indent guide (block-width)
let g:indent_guides_guide_size = 1

" ================
" VimPlug settings
" ================
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" Declare the list of plugins.

  " Essentials
  Plug 'tpope/vim-sensible'
  Plug 'mileszs/ack.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'preservim/nerdcommenter'
  " Theme and visuals
  Plug 'haishanh/night-owl.vim'
  Plug 'joshdick/onedark.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  " File system tree & navigation
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'majutsushi/tagbar'
  " Syntax
  Plug 'luochen1990/rainbow'
  Plug 'sheerun/vim-polyglot'
  Plug 'nathanaelkane/vim-indent-guides'
  Plug 'machakann/vim-highlightedyank'
  " Other
  Plug 'junegunn/vim-easy-align'
  Plug 'vim-scripts/matchit.zip'
  Plug 'easymotion/vim-easymotion'
  Plug 'justinmk/vim-sneak'
  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  " Autocompletion
  Plug 'jiangmiao/auto-pairs'
  Plug '~/.fzf'
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }
  Plug 'honza/vim-snippets'
  Plug 'mattn/emmet-vim'
  Plug 'tpope/vim-surround'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" ================
" Hotkeys settings
" ================
" <C> = CTRL
" <C-n> = CTRL + n
" <CR> = ENTER
" <Leader> = \ (starts with backslash)
" <silent> = no 'echo' in command log
"
" MODES legend:
" n - normal only
" v - visual & select
" o - operator pending
" x - visual only
" s - select only
" i - insert only
" c - command line (:)
" l - insert, regexp (/), command (:)
" map - nvso modes
" !map - ic modes

" Toggle NERDTree
map <silent> <C-\> :NERDTreeToggle<CR>
" Toggle Tagbar
nmap <silent> <F8> :TagbarToggle<CR>
" Default bind for Easy-Motion plugin
" map <Leader> <Plug>(easymotion-prefix)

" ==============
" Theme settings
" ==============
" Expand colors in terminal using GUI
if (has("termguicolors"))
  set termguicolors
endif

" Enable syntax highlight
syntax enable

" Set theme name
colorscheme onedark
" Set lightline (bottom bar) theme
let g:lightline = { 'colorscheme': 'onedark' }

" =================
" NERDTree settings
" =================
" Open a NERDTree automatically when vim starts up...
autocmd StdinReadPre * let s:std_in=1
" ... on opening a directory (e.g. '$ vim .')
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" =========================
" Rainbow brackets settings
" =========================
" Activate the rainbow brackets colors
let g:rainbow_active = 1

" ======================
" NERD Comments settings
" ======================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" ==================
" GitGutter settings
" ==================
" Path to Git in Windows
" let g:gitgutter_git_executable = 'C:/Program Files/Git/bin/git.exe'

" =======================
" vim-javascript settings
" =======================
" Activate conceals for JavaScript only
set conceallevel=1
" Conceals symbols
let g:javascript_conceal_function                  = "ƒ"
let g:javascript_conceal_null                      = "ø"
let g:javascript_conceal_this                      = "@"
let g:javascript_conceal_return                    = "⇚"
let g:javascript_conceal_undefined                 = "¿"
let g:javascript_conceal_NaN                       = "ℕ"
let g:javascript_conceal_prototype                 = "¶"
let g:javascript_conceal_static                    = "•"
let g:javascript_conceal_super                     = "Ω"
let g:javascript_conceal_arrow_function            = "⇒"
let g:javascript_conceal_noarg_arrow_function      = "🞅"
let g:javascript_conceal_underscore_arrow_function = "🞅"

" ====================================
" CoC (Conquer of Completion) settings
" ====================================
" TextEdit might fail if hidden is not set.
" This also allows VIM to abandon a buffer when editing another
" one even with unsaved changes.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <CR> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
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
  else
    call CocAction('doHover')
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

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<CR>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<CR>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<CR>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ==============
" Emmet settings
" ==============
" Enable it only for certain file types
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" Remap the default trigger key (<C-y>,)
let g:user_emmet_leader_key='<C-Z>'

" ============================
" VIM-HIGHLIGHTEDYANK settings
" ============================
" Duration of highlight in miliseconds (ms)
let g:highlightedyank_highlight_duration = 400
