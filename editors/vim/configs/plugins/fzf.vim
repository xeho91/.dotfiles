" =========================================================================== "
" Fzf settings
" ------------
" https://github.com/junegunn/fzf.vim
" =========================================================================== "

" This array is passed as arguments to fzf#vim#with_preview function.
" To learn more about preview window options, see '--preview-window'
" section of `man fzf`
let g:fzf_preview_window = ['down:50%']

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log'
let g:fzf_commits_log_options = '--graph --color=always " --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

let g:fzf_layout = {
	\ 'window': {
		\ 'width': 0.9,
		\ 'height': 0.9
	\ }
\ }

if has('nvim') && !exists('g:fzf_layout')
	augroup Fzf
		autocmd! FileType fzf
		autocmd FileType fzf set laststatus=0 noshowmode noruler
			\ | autocmd BufLeave <buffer> set laststatus=2 showmode ruler
	augroup END
endif

