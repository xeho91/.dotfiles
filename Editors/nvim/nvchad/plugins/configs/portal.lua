-- https://github.com/cbochs/portal.nvim

-- local present, portal = pcall(require, "portal")
--
-- if not present then
-- 	return
-- end

vim.keymap.set("n", "<leader>o", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>i", "<cmd>Portal jumplist forward<cr>")
