-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })

vim.api.nvim_create_autocmd("FocusGained", {
	command = "checktime",
})

local function current_buffer_path(modifier)
	local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), modifier)
	print(path ~= "" and path or "[No file name]")
end

vim.api.nvim_create_user_command("RelativePath", function()
	current_buffer_path(":.")
end, { desc = "Print the current buffer's relative path" })

vim.api.nvim_create_user_command("AbsolutePath", function()
	current_buffer_path(":p")
end, { desc = "Print the current buffer's absolute path" })

vim.api.nvim_create_user_command("Filename", function()
	current_buffer_path(":t")
end, { desc = "Print the current buffer's filename" })
