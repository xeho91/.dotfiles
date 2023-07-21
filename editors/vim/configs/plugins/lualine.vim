scriptencoding utf-8

" =========================================================================== "
" Lualine (statusline) settings
" ---------------------------------------
" https://github.com/hoob3rt/lualine.nvim
" =========================================================================== "

" Force Lualine theme to update on background color change
function! LightlineChangeColorscheme()
	let l:theme_path = fnameescape('autoload/lightline/colorscheme/' . g:colors_name . '.vim')
	execute 'source' globpath(&runtimepath, l:theme_path)
	call lightline#colorscheme()
	call lightline#update()
endfunction

augroup Lightline
	autocmd OptionSet background call LightlineChangeColorscheme()
augroup END

" Main configuration
let g:lualine = {
    \ 'options' : {
		\ 'section_separators'  : ['', ''],
		\ 'component_separators': ['', ''],
		\ 'icons_enabled'       : v:true,
    \ },
    \ 'sections' : {
		\ 'lualine_a': [ ['mode', {'upper': v:true,},], ],
		\ 'lualine_b': [ ['branch', {'icon': '',}, ], ],
		\ 'lualine_c': [ ['filename', {'file_status': v:true,},], ],
		\ 'lualine_x': [ 'encoding', 'fileformat', 'filetype' ],
		\ 'lualine_y': [ 'progress' ],
		\ 'lualine_z': [ 'location'  ],
    \ },
    \ 'inactive_sections' : {
		\ 'lualine_a': [  ],
		\ 'lualine_b': [  ],
		\ 'lualine_c': [ 'filename' ],
		\ 'lualine_x': [ 'location' ],
		\ 'lualine_y': [  ],
		\ 'lualine_z': [  ],
    \ },
	\ 'extensions' : [ 'fzf' ],
\ }

lua require("lualine").setup()
