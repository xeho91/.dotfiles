-- https://github.com/zbirenbaum/copilot.lua
-- https://github.com/github/copilot.vim
local present, copilot = pcall(require, "copilot")

if not present then
	return
end

local capitalize = function(str) end

vim.g.copilot_assume_mapped = true

copilot.setup {
	suggestion = { enabled = false },
	panel = { enabled = false },
}
