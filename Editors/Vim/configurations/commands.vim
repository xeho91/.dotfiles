" =========================================================================== "
" User defined commands
" ---------------------
" http://vimdoc.sourceforge.net/htmldoc/usr_40.html#40.2
" ---
" NOTE: User-defined commands must start with a capital letter
" =========================================================================== "

" Refresh (Neo)Vim configuration file
command! RefreshConfig source $VIMRC | echo "Refreshing config done!"

" Open and edit(Neo)Vim configuration file in a new tab
command! EditConfig tabedit $VIMRC

" --------------------------------------------------------------------------- "
"                                                     Toggle Dark/Light theme
" --------------------------------------------------------------------------- "
command! ThemeToggle call ChangeTheme()

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
command! ToggleQuickFixList call <SID>soggleQuickFixList()
let g:quickFix_is_open = 0
function s:soggleQuickFixList()
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
command! ToggleLocationList call <SID>ToggleLocationList()
let g:locationList_is_open = 0
function! s:soggleLocationList()
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

