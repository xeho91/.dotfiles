" =========================================================================== "
" Lightline (statusline/tabline) settings
" ---------------------------------------
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
			\ ['readonly', 'mode', 'paste'],
			\ ['gitfugitive', 'gitgutter', 'filename', 'modified'],
			\ ['vista']
		\ ],
		\ 'right': [
			\ ['lineinfo'],
			\ ['fileformat', 'fileencoding', 'filetype'],
			\ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']
		\ ],
	\ },
	\ 'tabline': {
		\ 'left': [['tabs']],
		\ 'right': [['close']],
	\ },
	\ 'component': {
		\ 'filename': '%f%<',
		\ 'lineinfo': '%3l:%-2v'
	\ },
	\ 'component_function': {
		\ 'readonly': 'LightlineReadOnly',
		\ 'fileformat': 'LightlineFileFormat',
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

" --------------------------------------------------------------------------- "
"                                                         Component functions
" --------------------------------------------------------------------------- "
" NOTE: Those which are dependant on plugin are in its own setting file

" Add which plugin is currently in use in mode block
" function! LightlineMode()
"     let functionName = expand('%:t')
"     return functionName =~# 'NERD_tree' ? 'NERDtree' : lightline#mode()
" endfunction

" Add a lock symbol if the file is readonly
function! LightlineReadOnly()
	return &readonly ? '' : ''
endfunction

" Add a lock symbol if the file is readonly
function! LightlineFileFormat()
	return &fileformat == "unix" ? '' : &fileformat
endfunction

