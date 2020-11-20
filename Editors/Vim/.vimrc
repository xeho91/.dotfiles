" ==============================================================================
" Reorganizing the location for (Neo)Vim files
" --------------------------------------------
" https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-directory
" ==============================================================================
set viminfo+=n$VIM_DIR/.viminfo
set runtimepath^=$VIM_DIR/vim
set runtimepath+=$VIM_DIR/vim/after
let &packpath = &runtimepath

" ============================================================================= "
let $VIM_CONFIG_DIR = expand("$VIM_DIR/configurations")

execute 'source' fnameescape($VIM_CONFIG_DIR . '/plugins.vim')
execute 'source' fnameescape($VIM_CONFIG_DIR . '/options.vim')
execute 'source' fnameescape($VIM_CONFIG_DIR . '/commands.vim')
execute 'source' fnameescape($VIM_CONFIG_DIR . '/maps.vim')

" " =============================================================================
" " Plugins settings
" " =============================================================================
"
" " Lightline (bottom bar) settings
" " -------------------------------
" " https://github.com/itchyny/lightline.vim
" "
" " Integrate it with CoC (Conquer of Completion)
" let g:lightline = {
"     \ 'colorscheme': 'gruvbox',
"     \ 'active': {
"         \ 'left': [
"             \ ['mode', 'paste'],
"             \ ['cocstatus', 'readonly', 'filename', 'modified']
"         \ ],
"         \ 'right': [
"             \ ['lineinfo'],
"             \ ['percent'],
"             \ ['fileformat', 'fileencoding', 'filetype'],
"             \ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']
"         \ ],
"     \ },
"     \ 'component_function': {
"         \ 'cocstatus': 'coc#status'
"     \ },
"     \ 'component_expand': {
"         \ 'linter_checking': 'lightline#ale#checking',
"         \ 'linter_infos': 'lightline#ale#infos',
"         \ 'linter_warnings': 'lightline#ale#warnings',
"         \ 'linter_errors': 'lightline#ale#errors',
"         \ 'linter_ok': 'lightline#ale#ok'
"     \ },
"     \ 'component_type': {
"         \ 'linter_checking': 'right',
"         \ 'linter_infos': 'right',
"         \ 'linter_warnings': 'warning',
"         \ 'linter_errors': 'error',
"         \ 'linter_ok': 'right'
"      \ }
" \ }
" " Use icons as indicators
" let g:lightline#ale#indicator_checking = "\uf110"
" let g:lightline#ale#indicator_infos = "\uf129 "
" let g:lightline#ale#indicator_warnings = "\uf071 "
" let g:lightline#ale#indicator_errors = "\uf05e "
" let g:lightline#ale#indicator_ok = "\uf00c"
" " Force Lightline update on background color change
" autocmd OptionSet background
"     \ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/gruvbox.vim')
"     \ | call lightline#colorscheme()
"     \ | call lightline#update()
" " Force Lightline update on CoC's status and diagnostic changes
" autocmd User CocStatusChange, CocDiagnosticChange call lightline#update()
" " Disable -- INSERT -- as is unnecessary anymore because the mode information
" " is displayed in the statusline
" set noshowmode
"
" " NERDTree settings
" " -----------------
" " https://github.com/preservim/nerdtree
" "
" " Binding to hotkey toggling NERDTree
" map <F7> :NERDTreeToggle<CR>
" "
" " If more than one window and previous buffer was NERDTree, go back to it.
" autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
" " Avoid crashes when calling Vim-Plug functions while the cursor is on the
" " NERDTree window
" let g:plug_window = 'noautocmd vertical topleft new'
" "
" " Move NERDTree to the right side
" let g:NERDTreeWinPos = "right"
" "
" " Open NERDTree automatically when Vim starts up on opening a directory
" autocmd StdinReadPre * let s:std_in=1
" " autocmd VimEnter * if argc() == 1
" "     \ && isdirectory(argv()[0])
" "     \ && !exists("s:std_in")
" "         \ | wincmd p | ene | exe 'NERDTree' argv()[0]
" " \ | endif
" " Close Vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1
"     \ && exists("b:NERDTree")
"     \ && b:NERDTree.isTabTree()) | q
" \ | endif
"
" " Rainbow bracket/parentheses settings
" " ------------------------------------
" " https://github.com/luochen1990/rainbow
" let g:rainbow_active = 1
"
" " Indent Guides settings
" " ----------------------
" " https://github.com/nathanaelkane/vim-indent-guides
" "
" " Enable guides on Vim startup
" let g:indent_guides_enable_on_vim_startup = 1
" "
" " Start indent guides from indent number...
" let g:indent_guides_start_level = 1
" "
" " Size of the indent guide (block-width)
" let g:indent_guides_guide_size = 1
"
" " NERD Commenter settings
" " -----------------------
" " https://github.com/preservim/nerdcommenter
" "
" " Add spaces after comment delimiters by default
" let g:NERDSpaceDelims = 1
" "
" " Use compact syntax for prettified multi-line comments
" let g:NERDCompactSexyComs = 1
" "
" " Align line-wise comment delimiters flush left
" " instead of following code indentation
" let g:NERDDefaultAlign = 'left'
" "
" " Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1
" "
" " Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" "
" " Allow commenting and inverting empty
" " lines (useful when commenting a region)
" let g:NERDCommentEmptyLines = 1
" "
" " Enable trimming of trailing whitespace when uncommenting
" let g:NERDTrimTrailingWhitespace = 1
" "
" " Enable NERDCommenterToggle to check all selected lines is commented or not
" let g:NERDToggleCheckAllLines = 1
"
" " Tagbar settings
" " ---------------
" " https://github.com/preservim/tagbar
" "
" " Bind toggle to hotkey
" nmap <F8> :TagbarToggle<CR>
"
" " Vim Easy Align settings
" " -----------------------
" " https://github.com/junegunn/vim-easy-align
" "
" " Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" "
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)
"
" " Limelight settings
" " ------------------
" " https://github.com/junegunn/limelight.vim
" "
" " Bind hotkey for toggling Limelight on and off
" map <F9> :Limelight!!<CR>
" "
" " Bind hotkey for invoking Limelight for a visual range
" " (NORMAL and VISUAL mode)
" nmap <Leader>l <Plug>(Limelight)
" xmap <Leader>l <Plug>(Limelight)
" "
" " Set the conceal level
" let g:limelight_default_coefficient = 0.8
"
" " Goyo settings
" " -------------
" " https://github.com/junegunn/goyo.vim
" "
" " Bind toggle Goyo to hotkey
" map <F10> :Goyo<CR>
" "
" " Integrate with Limelight plugin
" autocmd! User GoyoEnter Limelight
" autocmd! User GoyoLeave Limelight!
"
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
