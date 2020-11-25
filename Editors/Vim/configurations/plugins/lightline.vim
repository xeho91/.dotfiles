" =========================================================================== "
" Lightline (bottom bar) settings
" -------------------------------
" https://github.com/itchyny/lightline.vim
" =========================================================================== "

" Disable -- INSERT -- as is unnecessary anymore because the mode information
" is displayed in the statusline
set noshowmode

" Force Lightline theme colors to update on background color change
autocmd OptionSet background
	\ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/gruvbox.vim')
	\ | call lightline#colorscheme()
	\ | call lightline#update()

" Integrate it with CoC (Conquer of Completion)
let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ 'active': {
		\ 'left': [
			\ ['mode', 'paste'],
			\ ['gitfugitive', 'gitgutter'],
			\ ['readonly', 'filename', 'modified'],
			\ ['vista']
		\ ],
		\ 'right': [
			\ ['lineinfo'],
			\ ['percent'],
			\ ['fileformat', 'fileencoding', 'filetype'],
			\ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']
		\ ],
	\ },
	\ 'component': {
		\ 'filename': '%f%<',
		\ 'lineinfo': ' %3l:%-2v'
	\ },
	\ 'component_function': {
		\ 'readonly': 'LightlineReadonly',
		\ 'vista': 'LightlineVista',
		\ 'gitfugitive': 'LightlineGitFugitive',
		\ 'gitgutter': 'LightlineGitGutter'
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
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"


" =========================================================================== "
" Component functions
" =========================================================================== "

" Add a lock symbol if the file is readonly
function! LightlineReadonly()
	return &readonly ? '' : ''
endfunction

" Show current Git branch name
function! LightlineGitFugitive()
	if exists('*FugitiveHead')
		let branchName = FugitiveHead()
		return branchName !=# ''
			\ ? ' '. branchName
			\ : ''
	endif
	return ''
endfunction

" Show the nearest function or method with `Vista`
function! LightlineVista() abort
	return !empty(get(b:, 'vista_nearest_method_or_function', ''))
		\ ? ' ' . b:vista_nearest_method_or_function
		\ : ''
endfunction

" Show Git summary with `GitGutter`
function! LightLineGitGutter()
	if exists('*gitguttergethunksummary')
		let [added, modified, removed] = gitguttergethunksummary()
		return printf('+%d ~%d -%d', added, modified, removed)
	endif
	return ''
endfunction

