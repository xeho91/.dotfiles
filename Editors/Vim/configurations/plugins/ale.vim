scriptencoding utf-8

" ========================================================================== "
" ALE (Asynchronous Lint Engine) settings
" ---------------------------------------
" https://github.com/dense-analysis/ale
" =========================================================================== "

if has_key(g:plugs, 'aynscomplete-lsp.vim')
	let g:ale_disable_lsp = 1
endif

" Keep the sign gutter open at all times
let g:ale_sign_column_always = 1

" Change the signs on signcolumn (left column)
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

" Enable highlights
let g:ale_set_highlights = 1

" Open the list with Location List (`:lopen`) or Quickfix List (`:copen`)
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

" Navigate between problems quickly
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Highlight the problems
highlight ALEError guibg=Red guifg=Black
highlight ALEWarning guibg=Yellow guifg=Black

" --------------------------------------------------------------------------- "
"                                                                   Lightline
" --------------------------------------------------------------------------- "

" Use icons as indicators
let g:lightline#ale#indicator_infos = ' '
let g:lightline#ale#indicator_warnings = ' '
let g:lightline#ale#indicator_errors = ' '
let g:lightline#ale#indicator_ok = 'לּ'

" --------------------------------------------------------------------------- "
"                                                                      Fixers
" --------------------------------------------------------------------------- "

" Enable fixing on ...
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1

" Specify fixing tools for programming languages
let g:ale_fixers = {
	\ '*': ['trim_whitespace'],
	\ 'json': ['prettier'],
	\ 'yaml': ['prettier'],
	\ 'javascript': ['prettier']
\ }

