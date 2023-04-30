-- https://github.com/notomo/gesture.nvim

local gesture = require("gesture")
local vimp = require("vimp")

vim.o.mouse = "a"

vimp.nnoremap("<LeftDrag>", "<cmd>lua require('gesture').draw()<CR>")
vimp.nnoremap("<LeftRelease>", "<cmd>lua require('gesture').finish()<CR>")

gesture.register(
	{
		name = "scroll to bottom",
		inputs = {gesture.up(), gesture.down()},
		action = "normal! G"
	}
)
gesture.register(
	{
		name = "scroll to top",
		inputs = {gesture.down(), gesture.up()},
		action = "normal! gg"
	}
)
gesture.register(
	{
		name = "next tab",
		inputs = {gesture.right()},
		action = "tabnext"
	}
)
gesture.register(
	{
		name = "previous tab",
		inputs = {gesture.left()},
		action = function()
			-- also can use function
			vim.cmd("tabprevious")
		end
	}
)
gesture.register(
	{
		name = "go back",
		inputs = {gesture.right(), gesture.left()},
		-- map to `<C-o>` keycode
		action = [[lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-o>", true, false, true), "n", true)]]
	}
)
