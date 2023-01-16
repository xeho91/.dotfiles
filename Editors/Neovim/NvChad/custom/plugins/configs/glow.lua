-- https://github.com/ellisonleao/glow.nvim
local present, glow = pcall(require, "glow")

if not present then
	return
end

glow.setup {
	border = "shadow", -- floating window border config
	pager = false,
	width = 80,
	height = 100,
	width_ratio = 0.7, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
	height_ratio = 0.7,
}
