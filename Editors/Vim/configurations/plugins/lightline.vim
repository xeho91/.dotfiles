scriptencoding utf-8

" =========================================================================== "
" Lightline (statusline/tabline) settings
" ---------------------------------------
" https://github.com/itchyny/lightline.vim
" =========================================================================== "

" Disable `-- INSERT --` as is unnecessary anymore because the mode information
" is already displayed with this plugin
set noshowmode

" Force Lightline theme colors to update on background color change
autocmd OptionSet background
	\ execute 'source' globpath(&rtp, 'autoload/lightline/colorscheme/gruvbox.vim')
	\ | call lightline#colorscheme()
	\ | call lightline#update()

let g:lightline = {
	\ 'colorscheme': 'gruvbox',
	\ 'active': {
		\ 'left': [
			\ ['readonly', 'mode', 'paste'],
			\ ['gitfugitive', 'gitgutter', 'filetype', 'filename', 'modified'],
			\ ['vista']
		\ ],
		\ 'right': [
			\ ['lineinfo'],
			\ ['fileformat', 'fileencoding'],
			\ ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
			\ ['gutentags']
		\ ]
	\ },
	\ 'tabline': {
		\ 'left': [['tabs']],
		\ 'right': [['close']],
	\ },
	\ 'tab': {
		\ 'active': ['tabicon', 'filename'],
		\ 'inactive': ['tabnum', 'tabicon', 'filename']
	\ },
	\ 'mode_map': {
		\ 'n' : 'N',
		\ 'i' : 'I',
		\ 'R' : 'R',
		\ 'v' : 'V',
		\ 'V' : 'VL',
		\ "\<C-v>": 'VB',
		\ 'c' : 'C',
		\ 's' : 'S',
		\ 'S' : 'SL',
		\ "\<C-s>": 'SB',
		\ 't': 'T',
	\ },
	\ 'component': {
		\ 'filename': '%f%<',
		\ 'lineinfo': '%3l:%-2v'
	\ },
	\ 'component_function': {
		\ 'readonly': 'LightlineReadOnly',
		\ 'fileformat': 'LightlineFileFormat',
		\ 'fileencoding': 'LightlineFileEncoding',
		\ 'filetype': 'LightlineFileType',
		\ 'modified': 'LightlineModified',
		\ 'mode': 'LightlineMode',
		\ 'vista': 'LightlineVista',
		\ 'gitfugitive': 'LightlineGitFugitive',
		\ 'gitgutter': 'LightlineGitGutter',
		\ 'gutentags': 'gutentags#statusline'
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
	\ },
	\ 'tab_component_function': {
		\ 'tabicon': 'LightlineTabIcon'
	\ }
\ }

" --------------------------------------------------------------------------- "
"                                                         Component functions
" --------------------------------------------------------------------------- "
" NOTE: Those which are dependant on plugin are in its own setting file

" Add which plugin is currently in use in mode block
function! LightlineMode()
	let l:fileName = expand('%:t')
	if l:fileName ==# '__vista__'
		return 'Vista'
	elseif l:fileName ==# '__Mundo__'
		return 'Mundo'
	elseif l:fileName ==# '__Mundo_Preview__'
		return 'Mundo Preview'
	elseif l:fileName =~# 'NERD_tree'
		return 'NERDTree'
	else
		return winwidth(0) > 60 ? lightline#mode() : ''
	endif
endfunction

" Add a lock symbol if the file is readonly
function! LightlineReadOnly()
	return &readonly ? '' : ''
endfunction

" Add a lock symbol if the file is readonly
function! LightlineFileFormat()
	return &fileformat ==# 'unix' ? '' : &fileformat
endfunction

" Hide if pane (editor window) is too small
function! LightlineFileEncoding()
	return winwidth(0) > 80 ? &fileencoding : ''
endfunction

" Add an icon to file type if exists
function! LightlineFileType()
	let l:fileTypeIcon = WebDevIconsGetFileTypeSymbol()
	if l:fileTypeIcon !=# ''
		if winwidth(0) > 160
			return l:fileTypeIcon . ' ' . &filetype
		else
			return l:fileTypeIcon
		endif
	else
		return &filetype
	endif
endfunction

" Show an icon if the file is modified or not modifiable
function! LightlineModified()
	return &filetype =~# 'help'
		\ ? ''
		\ : &modified
			\ ? ''
			\ : &modifiable
				\ ? ''
				\ : ''
endfunction

" " https://vi.stackexchange.com/questions/21204/how-do-you-set-the-name-of-a-tab-page/21206#21206
" function! LightlineFileName()
"     if g:LightlineFileType !=# ''
"         return g:LightlineFileType() . ' ' . expand('%:t')
"     else
"         return expand('%:t')
"     endif
" endfunction

" Display filetype icon on the tab
function! LightlineTabIcon(tabNumber)
	let l:bufferNumber = tabpagebuflist(a:tabNumber)[tabpagewinnr(a:tabNumber) - 1]
	return WebDevIconsGetFileTypeSymbol(bufname(l:bufferNumber))
endfunction

