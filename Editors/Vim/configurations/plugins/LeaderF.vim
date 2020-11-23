" =========================================================================== "
" LeaderF settings
" ----------------
" https://github.com/Yggdroot/LeaderF
" =========================================================================== "

" Enable popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1

" Show icons, icons are shown by default
let g:Lf_ShowDevIcons = 1
let g:Lf_StlSeparator = get(g:, 'Lf_StlSeparator', { 'left': '', 'right': ''  })
let g:Lf_StlColorscheme = get(g:, 'spacevim_colorscheme', 'default')

let g:Lf_PreviewResult = {
	\ 'File': 0,
	\ 'Buffer': 0,
	\ 'Mru': 0,
	\ 'Tag': 0,
	\ 'BufTag': 0,
	\ 'Function': 0,
	\ 'Line': 0,
	\ 'Colorscheme': 0
\ }

" let g:Lf_CommandMap = {
"     \ '<C-J>' : ['<Tab>'],
"     \ '<C-K>' : ['<S-Tab>'],
"     \ '<C-R>' : ['<C-E>'],
"     \ '<C-X>' : ['<C-S>'],
"     \ '<C-]>' : ['<C-V>'],
"     \ '<C-F>' : ['<C-D>'],
"     \ '<Tab>' : ['<Esc>'],
" \ }

" disable default mru, and use neomru by defaul
augroup LeaderF_Mru
	autocmd!
	autocmd FileType leaderf setlocal nonumber
augroup END

" Change the leaderf Colorscheme automatically
augroup leaderf_layer_config
	autocmd!
	autocmd ColorScheme * let g:Lf_StlColorscheme = g:colors_name
augroup END

" Don't show the help in normal mod"e
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1

noremap <leader>ff :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>

" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

 " should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
" noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

