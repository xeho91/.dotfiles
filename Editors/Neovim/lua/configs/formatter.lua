-- https://github.com/mhartington/formatter.nvim

local vimp = require("vimp")
-- local autocmd = utils.autocmd

vimp.nmap("<leader>ff", "<cmd>Format<CR>")

require("formatter").setup(
	{
		logging = false,
		filetype = {
			-- Prettier
			javascript = {
				function()
					-- TODO: Use local config file, if exists
					local global_prettier_config_file =
						os.getenv("DOTFILES") .. "/Linters/.prettierrc.js"
					-- local local_prettier_config_file = "./.prettierrc.js"

					-- function file_exists(filePath)
					-- 	local f = io.open(filePath, "r")
					-- 	return f ~= nil and io.close(f)
					-- end

					return {
						exe = "prettier",
						args = {
							"--stdin-filepath",
							vim.api.nvim_buf_get_name(0),
							"--config " .. global_prettier_config_file
						},
						stdin = true
					}
				end
			},
			-- Lua-fmt
			lua = {
				function()
					return {
						exe = "luafmt",
						args = {
							"--indent-count=4",
							"--use-tabs",
							"--line-width=80",
							"--stdin"
						},
						stdin = true
					}
				end
			}
		}
	}
)

-- autocmd(
-- "Format",
-- {
-- [[ BufWritePost *.js,*.rs,*.lua FormatWrite ]]
-- },
-- true
-- )
