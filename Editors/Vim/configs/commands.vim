" =========================================================================== "
" User defined commands
" ---------------------
" http://vimdoc.sourceforge.net/htmldoc/usr_40.html#40.2
" ---
" NOTE: User-defined commands must start with a capital letter
" =========================================================================== "

" --------------------------------------------------------------------------- "
"                                              Refresh (Neo)Vim configuration
" --------------------------------------------------------------------------- "
command! RefreshConfig source $VIMRC | echomsg 'Refresh completed!'

" --------------------------------------------------------------------------- "
"                                 Reload plugin's specific configuration file
" --------------------------------------------------------------------------- "
command! -nargs=1 ReloadPluginConfiguration
	\ call g:plugins.reload_configuration('<args>')

" --------------------------------------------------------------------------- "
"                                            Edit (Neo)Vim configuration file
"                                                   (by opening in a new tab)
" --------------------------------------------------------------------------- "
command! EditConfig tabedit $VIMRC

" --------------------------------------------------------------------------- "
"                                                  Change theme to Dark/Light
" --------------------------------------------------------------------------- "
command! ChangeTheme call <SID>changeTheme()
function! s:changeTheme()
	if g:colors_name ==# g:theme.dark
		execute 'colorscheme ' . g:theme.light
		set background=light
	else
		execute 'colorscheme ' . g:theme.dark
		set background=dark
	endif

	echomsg '-- Changed theme to: ' . &background . ' --'
endfunction

" --------------------------------------------------------------------------- "
"                                                    Toggle hidden characters
" --------------------------------------------------------------------------- "
command! ToggleList call <SID>toggleList()
function! s:toggleList()
	let &list = ( &list ? 0 : 1)
	echomsg '-- Show hidden characters: ' . (&list ? 'ON' : 'OFF') . ' --'
endfunction

" --------------------------------------------------------------------------- "
"                                                        Toggle QuickFix list
" --------------------------------------------------------------------------- "
command! ToggleQuickFixList call <SID>toggleQuickFixList()
let g:quickFix_is_open = 0
function s:toggleQuickFixList()
	if g:quickFix_is_open
		cclose
		let g:quickFix_is_open = 0
	else
		copen
		let g:quickFix_is_open = 1
	endif
	echomsg '-- QuickFix List is: '
		\ . (g:quickFix_is_open ? 'OPEN' : 'CLOSED')
		\ . ' --'
endfunction

" --------------------------------------------------------------------------- "
"                                                        Toggle location list
" --------------------------------------------------------------------------- "
command! ToggleLocationList call <SID>toggleLocationList()
let g:locationList_is_open = 0
function! s:toggleLocationList()
	if g:locationList_is_open
		lclose
		let g:locationList_is_open = 0
	else
		lopen
		let g:locationList_is_open = 1
	endif
	echomsg '-- Location List is: '
		\ . (g:locationList_is_open ? 'OPEN' : 'CLOSED')
		\ . ' --'
endfunction

" --------------------------------------------------------------------------- "
"                                             Toggle search pattern highlight
" --------------------------------------------------------------------------- "
command! TogglePatternSearchHighlight call <SID>togglePatternSearchHighlight()
function! s:togglePatternSearchHighlight()
	let &hlsearch = &hlsearch ? 0 : 1
	echomsg '-- Search pattern highlight: ' . (&hlsearch ? 'ON' : 'OFF') . ' --'
endfunction

" --------------------------------------------------------------------------- "
"                                               Toggle help (editor's manual)
"                                         and search for key under the cursor
"                                         -----------------------------------
" Credits: https://vim.fandom.com/wiki/Disable_F1_built-in_help_key
" --------------------------------------------------------------------------- "
command! ToggleHelp call <SID>toggleHelp()
function s:toggleHelp()
	if &buftype ==# 'help'
		\ && match(strpart(getline('.'), col('.') - 1, 1), '\\S') < 0
		bwipeout
	else
		try
			exec 'help ' . expand('<cWORD>')
		catch /:E149:\|:E661:/
			" E149 no help for <subject>
			" E661 no <language> help for <subject>
			exec 'help ' . expand('<cword>')
		endtry
	endif
endfunction

" --------------------------------------------------------------------------- "
"                                             Open file search with `fzf.vim`
"        NOTE: It will start from the root path where `.git` directory exists
" --------------------------------------------------------------------------- "
command! OpenFileSearch call <SID>openFileSearch()
function s:openFileSearch()
	let l:Git_rootDirectory = finddir('.git/..', expand('%:p:h') . ';')
	try
		execute 'Files ' . l:Git_rootDirectory
	catch
		execute 'Files'
	endtry
endfunction

