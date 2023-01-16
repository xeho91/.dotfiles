-- https://github.com/cbochs/portal.nvim

local present, portal = pcall(require, "portal")

if not present then
	return
end

vim.keymap.set("n", "<leader>o", portal.jump_backward, {})
vim.keymap.set("n", "<leader>i", portal.jump_forward, {})
