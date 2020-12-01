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

" Toggle theme
command! ThemeToggle call ChangeTheme()

