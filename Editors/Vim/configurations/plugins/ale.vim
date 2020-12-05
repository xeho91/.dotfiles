" =========================================================================== "
" ALE (Asynchronous Lint Engine) settings
" ---------------------------------------
" https://github.com/dense-analysis/ale
" =========================================================================== "

" --------------------------------------------------------------------------- "
"                                                                 Sign column
"                                                (on the left before numbers)
" --------------------------------------------------------------------------- "

" Keep the sign gutter open at all times
let g:ale_sign_column_always = 1

" Change the signs on signcolumn (left column)
if g:enable_icons
	let g:ale_sign_error   = ' ' . g:icons.error
	let g:ale_sign_warning = ' ' . g:icons.warning
	let g:ale_sign_info    = ' ' . g:icons.info
endif

" --------------------------------------------------------------------------- "
"                                                            Diagnostics list
" --------------------------------------------------------------------------- "

" Open the list with Location List (`:lopen`) or Quickfix List (`:copen`)
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

" --------------------------------------------------------------------------- "
"                                                                    Mappings
" --------------------------------------------------------------------------- "

" Navigate between problems quickly
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" --------------------------------------------------------------------------- "
"                                                                  Highlights
" --------------------------------------------------------------------------- "

" Enable highlights
let g:ale_set_highlights = 1

" Highlight the problems
augroup UpdateALEhighlights
	autocmd ColorScheme * highlight! ALEError       guifg=#918175
	autocmd ColorScheme * highlight! ALEErrorLine   guibg=#400c0a
	autocmd ColorScheme * highlight! ALEWarning     guifg=#918175
	autocmd ColorScheme * highlight! ALEWarningLine guibg=#402f0a
	autocmd ColorScheme * highlight! ALEInfo        guifg=#918175
	autocmd ColorScheme * highlight! ALEInfoLine    guibg=#0f2840
augroup END

" --------------------------------------------------------------------------- "
"                                                                    Messages
" --------------------------------------------------------------------------- "

if g:enable_icons
	" `[%Severity%]` content
	let g:ale_echo_msg_error_str = g:icons.error
	let g:ale_echo_msg_warning_str = g:icons.warning
endif

" Message
let g:ale_echo_msg_format = '[%severity%] (%linter%) %s'

" --------------------------------------------------------------------------- "
"                                                            Fixing / Linting
" --------------------------------------------------------------------------- "

" Enable fixing on...
let g:ale_fix_on_save = 1

" Enable linting on...
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1

" Set lint delay in miliseconds
let g:ale_lint_delay = 500

" --------------------------------------------------------------------------- "
"                                                                      Fixers
" --------------------------------------------------------------------------- "

" Specify fixing tools for programming languages
let g:ale_fixers = {
	\ '*': ['trim_whitespace'],
	\ 'json': ['prettier'],
	\ 'yaml': ['prettier'],
	\ 'javascript': ['prettier'],
\ }

" let b:ale_linters = {
"     \ 'vim': ['vint'],
"     \ 'python': ['pylint'],
" \ }
