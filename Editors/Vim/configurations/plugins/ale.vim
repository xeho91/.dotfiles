" =========================================================================== "
" ALE (Asynchronous Lint Engine) settings
" ---------------------------------------
" https://github.com/dense-analysis/ale
" =========================================================================== "

" Let CoC handle LSP features and send diagnostic to ALE
let g:ale_disable_lsp = 1

" Keep the sign gutter open at all times
let g:ale_sign_column_always = 1

" Change the signs on signcolumn (left column)
let g:ale_sign_error = ""
let g:ale_sign_warning = ""

" Fixing
let g:ale_fixers = ['prettier']
let g:ale_fix_on_save = 1

" --------------------------------------------------------------------------- "
"                                                                   Lightline
" --------------------------------------------------------------------------- "

" Use icons as indicators
let g:lightline#ale#indicator_infos = " "
let g:lightline#ale#indicator_warnings = " "
let g:lightline#ale#indicator_errors = " "
let g:lightline#ale#indicator_ok = "לּ"

