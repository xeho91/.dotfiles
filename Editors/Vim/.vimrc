" =========================================================================== "
" Reorganizing the location for (Neo)Vim files
" --------------------------------------------
" https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-directory
" =========================================================================== "
let g:vim_home_dirPath = expand('$VIM_DIR')
set viminfo+=n"$VIM_DIR/.viminfo"

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
let g:vim_configurations_dirPath = expand('$HOME') . '\.dotfiles\Editors\Vim'

if g:enable_icons
	execute 'source' fnameescape(g:vim_configurations_dirPath . '\icons.vim')
endif
execute 'source' fnameescape(g:vim_configurations_dirPath . '\plugins.vim')
execute 'source' fnameescape(g:vim_configurations_dirPath . '\mappings.vim')
execute 'source' fnameescape(g:vim_configurations_dirPath . '\options.vim')
execute 'source' fnameescape(g:vim_configurations_dirPath . '\commands.vim')
execute 'source' fnameescape(g:vim_configurations_dirPath . '\themes.vim')

" =========================================================================== "
" Other
" =========================================================================== "

" Close help faster with pressing `q`
augroup vimrc
	autocmd FileType help noremap <buffer> q :quit<CR>
augroup END

