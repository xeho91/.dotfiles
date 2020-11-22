" =========================================================================== "
" ALE (Asynchronous Lint Engine) settings
" ---------------------------------------
" https://github.com/dense-analysis/ale
" =========================================================================== "

" Let CoC handle LSP features and send diagnostic to ALE
let g:ale_disable_lsp = 1

" Keep the sign gutter open at all times
let g:ale_sign_column_always = 1

" Change the signs on signcolumn
let g:ale_sign_error = "\uf05e"
let g:ale_sign_warning = "\uf071"

" Fixing
let g:ale_fixers = ['prettier']
let g:ale_fix_on_save = 1

