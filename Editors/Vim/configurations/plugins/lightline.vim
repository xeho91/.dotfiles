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
function! LightlineChangeColorscheme()
	let l:theme_path = fnameescape('autoload/lightline/colorscheme/' . g:colors_name . '.vim')
	execute 'source' globpath(&runtimepath, l:theme_path)
	call lightline#colorscheme()
	call lightline#update()
endfunction
autocmd OptionSet background call LightlineChangeColorscheme()

" Main configuration
let g:lightline = {
	\ 'active': {
		\ 'left': [
			\ ['readonly', 'mode', 'paste'],
			\ ['filetype', 'filename', 'modified']
		\ ],
		\ 'right': [
			\ ['lineinfo'],
			\ ['fileformat', 'fileencoding']
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
	\ 'component_expand': {},
	\ 'component_type': {},
	\ 'component_function': {
		\ 'readonly': 'LightlineReadOnly',
		\ 'fileformat': 'LightlineFileFormat',
		\ 'fileencoding': 'LightlineFileEncoding',
		\ 'filetype': 'LightlineFileType',
		\ 'filename': 'LightlineFileName',
		\ 'modified': 'LightlineModified',
		\ 'mode': 'LightlineMode'
	\ },
	\ 'tab_component_function': {
		\ 'tabicon': 'LightlineTabIcon'
	\ }
\ }

" --------------------------------------------------------------------------- "
"                                                         Component functions
" --------------------------------------------------------------------------- "

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
	elseif l:fileName =~# '__CtrlSF__'
		return 'CtrlSF'
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

" Shorten the filepath
function! LightlineFileName()
	let l:filePath = expand('%')
	if winwidth(0) > 160
		return ' ' . l:filePath
	else
		return ' ' . pathshorten(l:filePath)
	endif
endfunction

" Display filetype icon on the tab
function! LightlineTabIcon(tabNumber)
	let l:bufferNumber = tabpagebuflist(a:tabNumber)[tabpagewinnr(a:tabNumber) - 1]
	return WebDevIconsGetFileTypeSymbol(bufname(l:bufferNumber))
endfunction

" --------------------------------------------------------------------------- "
"                                                         Plugins integration
" --------------------------------------------------------------------------- "

if has_key(g:plugs, 'vista.vim')
	let g:lightline.active.left += [['vista']]
	let g:lightline.component_function.vista = 'LightlineVista'
	autocmd vimrc VimEnter * call vista#RunForNearestMethodOrFunction()
	" Show the nearest function in statusline with vista.vim plugin
	function! LightlineVista()
		return !empty(get(b:, 'vista_nearest_method_or_function', ''))
			\ ? ' ' . b:vista_nearest_method_or_function
			\ : ''
	endfunction
endif

if has_key(g:plugs, 'vim-gitgutter')
	let g:lightline.active.left[1] = ['gitgutter'] + g:lightline.active.left[1]
	let g:lightline.component_function.gitgutter = 'LightlineGitgutter'
	" Show Git summary with vim-gitgutter plugin
	function! LightlineGitgutter()
		if winwidth(0) > 160
			let [l:added, l:modified, l:removed] = GitGutterGetHunkSummary()
			if l:added == 0 && l:modified == 0 && l:removed == 0
				return ''
			endif
			return printf('%d %d %d', l:added, l:modified, l:removed)
		else
			return ''
		endif
	endfunction
endif

if has_key(g:plugs, 'vim-fugitive')
	let g:lightline.active.left[1] = ['fugitive'] + g:lightline.active.left[1]
	let g:lightline.component_function.fugitive = 'LightlineFugitive'
	" Show current Git branch name in Lightline statusline
	function! LightlineFugitive()
		let l:branchName = FugitiveHead()
		if l:branchName ==# ''
			return ''
		elseif winwidth(0) < 160 && len(l:branchName) > 10
			return 'שׂ ' . l:branchName[:2] . '..' . l:branchName[(len(l:branchName) - 4):]
		else
			return 'שׂ ' . l:branchName
		endif
	endfunction
endif

if has_key(g:plugs, 'lightline-ale')
	let g:lightline.active.right += [[
		\ 'linter_checking',
		\ 'linter_errors',
		\ 'linter_warnings',
		\ 'linter_infos',
		\ 'linter_ok'
	\ ]]
	let g:lightline.component_expand = extend(g:lightline.component_expand, {
		\ 'linter_checking': 'lightline#ale#checking',
		\ 'linter_infos': 'lightline#ale#infos',
		\ 'linter_warnings': 'lightline#ale#warnings',
		\ 'linter_errors': 'lightline#ale#errors',
		\ 'linter_ok': 'lightline#ale#ok',
	\ })
	let g:lightline.component_type = extend(g:lightline.component_type, {
		\ 'linter_checking': 'right',
		\ 'linter_infos ': 'right',
		\ 'linter_warnings': 'warning',
		\ 'linter_errors': 'error',
		\ 'linter_ok': 'right'
	\ })
endif

if has_key(g:plugs, 'vim-gutentags')
	let g:lightline.active.right += [['gutentags']]
	let g:lightline.component_function.gutentags = 'gutentags#statusline'
endif

