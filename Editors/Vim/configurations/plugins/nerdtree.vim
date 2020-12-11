" =========================================================================== "
" NERDTree settings
" -----------------
" https://github.com/preservim/nerdtree
" =========================================================================== "

" Set location for NERDtree bookmarks file
let g:NERDTreeBookmarksFile = fnameescape(
	\ g:vim_home_dirPath . '.NERDtreeBookmarks'
\ )

" Move NERDTree to the right side
let g:NERDTreeWinPos = 'right'

" Show hidden files (starting with dot `.`)
let g:NERDTreeShowHidden = 1

" Avoid crashes when calling Vim-Plug functions while the cursor is on the
" NERDTree window
let g:plug_window = 'noautocmd vertical topleft new'

augroup NERDTree
	" If more than one window and previous buffer was NERDTree, go back to it
	autocmd BufEnter * if bufname('#') =~# '^NERD_tree_' && winnr('$') > 1 | b# | endif

	" Open NERDTree automatically when Vim starts up on opening a directory
	autocmd StdinReadPre * let s:std_in=1
	" autocmd VimEnter * if argc() == 1
	"     \ && isdirectory(argv()[0])
	"     \ && !exists("s:std_in")
	"         \ | wincmd p | ene | exe 'NERDTree' argv()[0]
	" \ | endif
	" Close Vim if the only window left open is a NERDTree
	autocmd bufenter * if (winnr('$') == 1
				\ && exists("b:NERDTree")
				\ && b:NERDTree.isTabTree()) | q
				\ | endif
augroup END

