" =========================================================================== "
" Startify settings
" -----------------
" https://github.com/mhinz/vim-startify
" =========================================================================== "

" Returns all modified files of the current git repo `2>/dev/null` makes the
" command fail quietly, so that when we are not in a git repo, the list will
" be empty
function! s:gitModified()
	let l:files = systemlist('git ls-files -m 2>/dev/null')
	return map(l:files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
	let l:files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
	return map(l:files, "{'line': v:val, 'path': v:val}")
endfunction

" Display NERDtree bookmarks (as a separate list)
" Read ~/.NERDTreeBookmarks file and takes its second column
function! s:nerdtreeBookmarks()
	let l:bookmarks = systemlist("cut -d' ' -f 2 $VIM_DIR[HOME]/.NERDtreeBookmarks")
	let l:bookmarks = l:bookmarks[0:-2] " Slices an empty last line
	return map(l:bookmarks, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
	\ { 'type': function('s:nerdtreeBookmarks'), 'header': ['NERDTree Bookmarks'] },
	\ { 'type': 'files', 'header': ['MRU (Most Recently Used) files'] },
	\ { 'type': 'dir', 'header': ['MRU (Most Recently Used) directory - ' . getcwd()] },
	\ { 'type': 'sessions', 'header': ['Sessions'] },
	\ { 'type': 'bookmarks', 'header': ['Bookmarks'] },
	\ { 'type': function('s:gitModified'), 'header': ['Git modified'] },
	\ { 'type': function('s:gitUntracked'), 'header': ['Git untracked'] },
	\ { 'type': 'commands', 'header': ['Commands'] }
\ ]

