scriptencoding utf-8

" =========================================================================== "
" Vim fugitive settings
" ---------------------
" https://github.com/tpope/vim-fugitive
" =========================================================================== "

" --------------------------------------------------------------------------- "
"                                                                   Lightline
" --------------------------------------------------------------------------- "

" Show current Git branch name in Lightline statusline
function! LightlineGitFugitive()
	let l:branchName = FugitiveHead()
	if l:branchName ==# ''
		return ''
	elseif winwidth(0) < 160 && len(l:branchName) > 10
		return 'שׂ ' . l:branchName[:2] . '..' . l:branchName[(len(l:branchName) - 4):]
	else
		return 'שׂ ' . l:branchName
	endif
endfunction

