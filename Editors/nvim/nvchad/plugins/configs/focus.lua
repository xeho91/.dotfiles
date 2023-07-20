local present, focus = pcall(require, "focus")

if not present then
	return
end

-- https://github.com/nvim-focus/focus.nvim
focus.setup {
	enable = true,
	hybridnumber = true,
	excluded_filetypes = { "toggleterm" },
}
