return {
	{
		-- https://github.com/nickjvandyke/opencode.nvim
		"nickjvandyke/opencode.nvim",
		version = "*",
		config = function()
			local host = vim.env.OPENCODE_HOST or "http://127.0.0.1"
			local port = tonumber(vim.env.OPENCODE_PORT) or 4096
			local url = string.format("%s:%d", host, port)

			---@type opencode.Opts
			vim.g.opencode_opts = {
				server = {
					url = url,
				},
			}

			vim.o.autoread = true

			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ")
			end, { desc = "Ask OpenCode…" })

			vim.keymap.set({ "n", "x" }, "<C-x>", function()
				require("opencode").select()
			end, { desc = "Select OpenCode…" })

			vim.keymap.set({ "n", "x" }, "go", function()
				return require("opencode").operator("@this ")
			end, { desc = "Append range to OpenCode", expr = true })

			vim.keymap.set({ "n" }, "goo", function()
				return require("opencode").operator("@this ") .. "_"
			end, { desc = "Append line to OpenCode", expr = true })

			vim.keymap.set({ "n" }, "<S-C-u>", function()
				require("opencode").command("session.half.page.up")
			end, { desc = "Scroll OpenCode up" })

			vim.keymap.set({ "n" }, "<S-C-d>", function()
				require("opencode").command("session.half.page.down")
			end, { desc = "Scroll OpenCode down" })
		end,
	},
}
