" =========================================================================== "
" Reorganizing the location for (Neo)Vim files
" --------------------------------------------
" https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-directory
" =========================================================================== "
let g:vim_home_dirPath = fnameescape(expand('$DOTFILES') . '/Editors/Vim')
let g:vim_config_dirPath = g:vim_home_dirPath . '/configs'

" https://stackoverflow.com/questions/23012391/how-and-where-is-my-viminfo-option-set
" set viminfo+=n/.viminfo"

" =========================================================================== "
" Important
" =========================================================================== "
let g:ale_disable_lsp = 1
let g:enable_icons    = 1
let g:mapleader       = '\'
let g:maplocalleader  = ','

" =========================================================================== "
" Load configuration files for (Neo)Vim
" =========================================================================== "

if g:enable_icons
	execute 'source' fnameescape(g:vim_config_dirPath . '/icons.vim')
endif
execute 'source' fnameescape(g:vim_config_dirPath . '/plugins.vim')
execute 'source' fnameescape(g:vim_config_dirPath . '/mappings.vim')
execute 'source' fnameescape(g:vim_config_dirPath . '/options.vim')
execute 'source' fnameescape(g:vim_config_dirPath . '/commands.vim')
execute 'source' fnameescape(g:vim_config_dirPath . '/themes.vim')

" =========================================================================== "
" Other
" =========================================================================== "

" Close help faster with pressing `q`
augroup vimrc
	autocmd FileType help noremap <buffer> q :quit<CR>
augroup END
