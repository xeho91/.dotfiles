" =========================================================================== "
" Ack settings
" ------------
" https://github.com/mileszs/ack.vim
" =========================================================================== "

if executable('rg')
	" Options include:
	" `--vimgrep` -> needed to parse the rg response properly for ack.vim
	" `--type-not sql` -> Avoid huge sql file dumps as it slows down the
	" search
	" `--smart-case` -> Search case insensitive if all lowercase pattern,
	" search case sensitively otherwise
	let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'
elseif executable('ag')
	let g:ackprg = 'ag --vimgrep'
endif

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps <leader>/ so we're ready to type the search keyword
nnoremap <Leader>/ :Ack!<Space>

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

