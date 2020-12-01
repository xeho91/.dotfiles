" =========================================================================== "
" Reorganizing the location for (Neo)Vim files
" --------------------------------------------
" https://vi.stackexchange.com/questions/11879/how-can-put-vimrc-and-viminfo-into-vim-directory
" =========================================================================== "
set viminfo+=n"$VIM_DIR[HOME]/.viminfo"
let g:vim_home_dir_path = expand('$VIM_DIR[HOME]')

" =========================================================================== "
" Load (Neo)Vim's configuration files
" =========================================================================== "
let g:vim_configs_dir_path = expand('$VIM_DIR[CONFIGS]')
execute 'source' fnameescape(g:vim_configs_dir_path . 'plugins.vim')
execute 'source' fnameescape(g:vim_configs_dir_path . 'options.vim')
execute 'source' fnameescape(g:vim_configs_dir_path . 'commands.vim')
execute 'source' fnameescape(g:vim_configs_dir_path . 'mappings.vim')
execute 'source' fnameescape(g:vim_configs_dir_path . 'themes.vim')

