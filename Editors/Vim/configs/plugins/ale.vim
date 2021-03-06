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

" Open the list with 'Location List' (`:lopen`) or with 'Quickfix List' (`:copen`)
let g:ale_open_list             = 0
let g:ale_keep_list_window_open = 0

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
	let g:ale_echo_msg_error_str   = g:icons.error
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
let g:ale_lint_on_enter        = 1

" Set lint delay in miliseconds
let g:ale_lint_delay = 400

" --------------------------------------------------------------------------- "
"                                                                      Fixers
" --------------------------------------------------------------------------- "

let g:ale_fixers = {
	\ '*':          ['trim_whitespace'],
	\ 'css':        ['prettier', 'stylelint'],
	\ 'html':       ['prettier'],
	\ 'javascript': ['prettier'],
	\ 'json':       ['prettier'],
	\ 'markdown':   ['prettier'],
	\ 'yaml':       ['prettier'],
\ }

" --------------------------------------------------------------------------- "
"                                                                     Linters
" --------------------------------------------------------------------------- "

let b:ale_linters = {
	\ 'css':      ['stylelint'],
	\ 'html':     ['htmlhint'],
	\ 'markdown': ['markdownlint', 'proselint'],
	\ 'python':   ['pylint'],
	\ 'vim':      ['vint'],
\ }

" https://stylelint.io/user-guide/usage/options
let g:ale_html_htmlhint_options = '--config "$DOTFILES/Linters/.htmlhintrc.js"'

" https://stylelint.io/user-guide/usage/options
let g:ale_css_stylelint_options = '--config "$DOTFILES/Linters/.stylelintrc.js"'

" https://prettier.io/docs/en/cli.html
let g:ale_javascript_prettier_options = '--config "$DOTFILES/Linters/.prettierrc.js"'

" https://github.com/igorshubovych/markdownlint-cli#usage
let g:ale_markdown_markdownlint_options = '--config "$DOTFILES/Linters/.markdownlint.json"'

