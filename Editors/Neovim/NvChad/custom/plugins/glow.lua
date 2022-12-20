local present, glow = pcall(require, "glow")

if not present then
	return
end

-- https://github.com/ellisonleao/glow.nvim
vim.g.glow_border = "rounded"
vim.g.glow_width = 80
vim.g.glow_use_pager = false
vim.g.glow_style = "dark"
