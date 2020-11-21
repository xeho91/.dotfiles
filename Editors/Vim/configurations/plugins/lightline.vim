" =========================================================================== "
" Lightline (bottom bar) settings
" -------------------------------
" https://github.com/itchyny/lightline.vim
" =========================================================================== "

" Integrate it with CoC (Conquer of Completion)
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ 'active': {
		\ 'left': [
			\ ['mode', 'paste'],
			\ ['cocstatus', 'readonly', 'filename', 'modified']
		\ ],
		\ 'right': [
			\ ['lineinfo'],
			\ ['percent'],
			\ ['fileformat', 'fileencoding', 'filetype'],
			\ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']
		\ ],
	\ },
		\ 'component_function': {
		\ 'cocstatus': 'coc#status'
	\ },
	\ 'component_expand': {
		\ 'linter_checking': 'lightline#ale#checking',
		\ 'linter_infos': 'lightline#ale#infos',
		\ 'linter_warnings': 'lightline#ale#warnings',
		\ 'linter_errors': 'lightline#ale#errors',
		\ 'linter_ok': 'lightline#ale#ok'
	\ },
	\ 'component_type': {
		\ 'linter_checking': 'right',
		\ 'linter_infos': 'right',
		\ 'linter_warnings': 'warning',
		\ 'linter_errors': 'error',
		\ 'linter_ok': 'right'
	\ }
\ }

" Use icons as indicators
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"

" Force Lightline update on background color change
autocmd OptionSet background
	\ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/gruvbox.vim')
	\ | call lightline#colorscheme()
	\ | call lightline#update()

" Force Lightline update on CoC's status and diagnostic changes
autocmd User CocStatusChange, CocDiagnosticChange call lightline#update()

" Disable -- INSERT -- as is unnecessary anymore because the mode information
" is displayed in the statusline
set noshowmode

