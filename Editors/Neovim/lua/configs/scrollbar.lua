-- https://github.com/Xuyuanp/scrollbar.nvim

local utils = require("utils")
local autocmd = utils.autocmd

autocmd(
	"ScrollbarInit",
	{
		[[ CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show() ]],
		[[ WinEnter,FocusGained           * silent! lua require('scrollbar').show() ]],
		[[ WinLeave,FocusLost             * silent! lua require('scrollbar').clear() ]]
	},
	true
)
