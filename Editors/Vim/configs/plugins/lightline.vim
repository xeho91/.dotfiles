scriptencoding utf-8

" =========================================================================== "
" Lightline (statusline/tabline) settings
" ---------------------------------------
" https://github.com/itchyny/lightline.vim
" =========================================================================== "

" Force Lightline theme colors to update on background color change
function! LightlineChangeColorscheme()
	let l:theme_path = fnameescape('autoload/lightline/colorscheme/' . g:colors_name . '.vim')
	execute 'source' globpath(&runtimepath, l:theme_path)
	call lightline#colorscheme()
	call lightline#update()
endfunction
augroup Lightline
	autocmd OptionSet background call LightlineChangeColorscheme()
augroup END

" Main configuration
let g:lightline = {
	\ 'active': {
		\ 'left': [
			\ ['readonly', 'mode', 'paste'],
			\ ['filename','filetype', 'modified']
		\ ],
		\ 'right': [
			\ ['lineinfo'],
			\ ['indentation', 'fileencoding', 'fileformat']
		\ ]
	\ },
	\ 'tabline': {
		\ 'left':  [['tabs']],
		\ 'right': [['close']],
	\ },
	\ 'tab': {
		\ 'active':   ['tabicon', 'filename'],
		\ 'inactive': ['tabnum', 'tabicon', 'filename']
	\ },
	\ 'mode_map': {
		\ 'n':      'N',
		\ 'i':      'I',
		\ 'R':      'R',
		\ 'v':      'V',
		\ 'V':      'VL',
		\ "\<C-v>": 'VB',
		\ 'c':      'C',
		\ 's':      'S',
		\ 'S':      'SL',
		\ "\<C-s>": 'SB',
		\ 't':      'T',
	\ },
	\ 'component': {
		\ 'filename': '%f%<',
		\ 'lineinfo': '%3l:%-2v'
	\ },
	\ 'component_expand': {},
	\ 'component_type': {},
	\ 'component_function': {
		\ 'readonly':     'LightlineReadOnly',
		\ 'fileformat':   'LightlineFileFormat',
		\ 'fileencoding': 'LightlineFileEncoding',
		\ 'filetype':     'LightlineFileType',
		\ 'filename':     'LightlineFileName',
		\ 'modified':     'LightlineModified',
		\ 'mode':         'LightlineMode',
		\ 'indentation':  'LightlineIndentation'
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
	if g:enable_icons
		return &readonly ? '' : ''
	else
		return &readonly ? 'RO' : ''
	endif
endfunction

" Add information if the file is readonly
function! LightlineFileFormat()
	if g:enable_icons
		return &fileformat ==# 'unix' ? '' : &fileformat
	else
		return &fileformat
	endif
endfunction

" Hide if editor's window (or pane) is too small
function! LightlineFileEncoding()
	return winwidth(0) > 80 ? &fileencoding : ''
endfunction

" Add an icon to file type if exists
function! LightlineFileType()
	if g:enable_icons && g:plugins.is_installed('devicons')
		let l:fileTypeIcon = WebDevIconsGetFileTypeSymbol()
		if l:fileTypeIcon !=# ''
			if winwidth(0) > 120
				return l:fileTypeIcon . ' ' . &filetype
			else
				return l:fileTypeIcon
			endif
		else
			return &filetype
		endif
	else
		return &filetipe
	endif
endfunction

" Show an icon if the file is modified or not modifiable
function! LightlineModified()
	if &modifiable
		if &modified
			return g:enable_icons ? '' : '+'
		else
			return ''
		endif
	else
		return g:enable_icons ? '' : '!'
	endif
endfunction

" Shorten the filepath
function! LightlineFileName()
	let l:filePath = expand('%')
	if winwidth(0) > 160
		return (g:enable_icons ? ' ' : '') . l:filePath
	else
		return (g:enable_icons ? ' ' : '') . pathshorten(l:filePath)
	endif
endfunction

" Display filetype icon on the tab
function! LightlineTabIcon(tabNumber)
	if g:enable_icons && g:plugins.is_installed('devicons')
		let l:bufferNumber = tabpagebuflist(a:tabNumber)[
			\ tabpagewinnr(a:tabNumber) - 1
		\ ]
		return WebDevIconsGetFileTypeSymbol(bufname(l:bufferNumber))
	else
		return ''
	endif
endfunction

" Display what indenation is set for current file
function! LightlineIndentation()
	if winwidth(0) > 80
		if &expandtab
			return 'Spaces: ' . &shiftwidth
		else
			return 'Tabs: ' . &tabstop
		endif
	else
		return ''
	endif
endfunction

" =========================================================================== "
" Plugins integration
" =========================================================================== "

" --------------------------------------------------------------------------- "
"                                                                       Vista
" https://github.com/liuchengxu/vista.vim
" --------------------------------------------------------------------------- "
if g:plugins.is_installed('vista')
	let g:lightline.active.left += [['vista']]
	let g:lightline.component_function.vista = 'LightlineVista'
	autocmd Lightline VimEnter * call vista#RunForNearestMethodOrFunction()
	" Show the nearest function in statusline with vista.vim plugin
	function! LightlineVista()
		let l:icon = g:enable_icons ? g:icons.functionSymbol . ' ' : ''
		return !empty(get(b:, 'vista_nearest_method_or_function', ''))
			\ ? l:icon . b:vista_nearest_method_or_function
			\ : ''
	endfunction
endif

" --------------------------------------------------------------------------- "
"                                                                   Gitgutter
" https://github.com/airblade/vim-gitgutter
" --------------------------------------------------------------------------- "
if g:plugins.is_installed('gitgutter')
	let g:lightline.active.left[1] = ['gitgutter'] + g:lightline.active.left[1]
	let g:lightline.component_function.gitgutter = 'LightlineGitgutter'
	" Show Git summary with vim-gitgutter plugin
	function! LightlineGitgutter()
		let l:icons = g:enable_icons ? '%d %d %d' : '+%d ~%d -%d'
		if winwidth(0) > 160
			let [l:added, l:modified, l:removed] = GitGutterGetHunkSummary()
			if l:added == 0 && l:modified == 0 && l:removed == 0
				return ''
			endif
			return printf(l:icons, l:added, l:modified, l:removed)
		else
			return ''
		endif
	endfunction
endif

" --------------------------------------------------------------------------- "
"                                                                    Fugitive
" https://github.com/tpope/vim-fugitive
" --------------------------------------------------------------------------- "
if g:plugins.is_installed('fugitive')
	let g:lightline.active.left[1] = ['fugitive'] + g:lightline.active.left[1]
	let g:lightline.component_function.fugitive = 'LightlineFugitive'
	" Show current Git branch name in Lightline statusline
	function! LightlineFugitive()
		let l:icon = g:enable_icons ? g:icons.git.branch . ' ' : ''
		let l:branchName = FugitiveHead()
		if l:branchName ==# ''
			return ''
		elseif winwidth(0) < 160 && len(l:branchName) > 10
			return l:icon . l:branchName[:2]
				\ . '..'
				\ . l:branchName[(len(l:branchName) - 4):]
		else
			return l:icon . l:branchName
		endif
	endfunction
endif

" --------------------------------------------------------------------------- "
"                                                                         ALE
" --------------------------------------------------------------------------- "
if g:plugins.is_installed('lightline-ale')
	let g:lightline.active.right += [[
		\ 'linter_checking',
		\ 'linter_errors',
		\ 'linter_warnings',
		\ 'linter_infos',
		\ 'linter_ok'
	\ ]]
	let g:lightline.component_expand = extend(g:lightline.component_expand, {
		\ 'linter_checking': 'lightline#ale#checking',
		\ 'linter_infos':    'lightline#ale#infos',
		\ 'linter_warnings': 'lightline#ale#warnings',
		\ 'linter_errors':   'lightline#ale#errors',
		\ 'linter_ok':       'lightline#ale#ok',
	\ })
	let g:lightline.component_type = extend(g:lightline.component_type, {
		\ 'linter_checking': 'right',
		\ 'linter_infos':    'right',
		\ 'linter_warnings': 'warning',
		\ 'linter_errors':   'error',
		\ 'linter_ok':       'right'
	\ })
	if g:enable_icons
		" Use icons as indicators
		let g:lightline#ale#indicator_infos    = g:icons.info
		let g:lightline#ale#indicator_warnings = g:icons.warning
		let g:lightline#ale#indicator_errors   = g:icons.error
		let g:lightline#ale#indicator_ok       = g:icons.ok
	endif
endif

" --------------------------------------------------------------------------- "
"                                                                   Gutentags
" --------------------------------------------------------------------------- "
if g:plugins.is_installed('gutentags')
	let g:lightline.active.right += [['gutentags']]
	let g:lightline.component_function.gutentags = 'gutentags#statusline'
endif

" --------------------------------------------------------------------------- "
"                                                                         CoC
" --------------------------------------------------------------------------- "
if g:plugins.is_installed('coc')
	let g:lightline.active.right += [['cocstatus']]
	let g:lightline.component_function.cocstatus = 'coc#status'
endif

