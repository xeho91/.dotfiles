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
command! ToggleList call Function_ToggleList()
function! Function_ToggleList()
	let &list = ( &list ? 0 : 1)
	echomsg '-- Show hidden characters: ' . (&list ? 'ON' : 'OFF') . ' --'
endfunction

" --------------------------------------------------------------------------- "
"                                                        Toggle QuickFix list
" --------------------------------------------------------------------------- "
command! ToggleQuickFixList call Function_ToggleQuickFixList()
let g:quickFix_is_open = 0
function Function_ToggleQuickFixList()
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
command! ToggleLocationList call Function_ToggleLocationList()
let g:locationList_is_open = 0
function! Function_ToggleLocationList()
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

