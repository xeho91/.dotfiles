return {
	{
		-- https://github.com/nickjvandyke/opencode.nvim
		"nickjvandyke/opencode.nvim",
		config = function()
			local host = vim.env.OPENCODE_SERVER_HOSTNAME or "127.0.0.1"
			local port = tonumber(vim.env.OPENCODE_SERVER_PORT) or 4096
			local url = string.format("http://%s:%d", host, port)
			local password = vim.env.OPENCODE_SERVER_PASSWORD

			if not password or password == "" then
				local output = vim.fn.system({ "fnox", "get", "OPENCODE_SERVER_PASSWORD" })
				local exit_code = vim.v.shell_error
				local fetched_password = vim.trim(output)

				if exit_code == 0 and fetched_password ~= "" then
					password = fetched_password
				else
					vim.notify(
						"Unable to load OpenCode server password with fnox (exit " .. exit_code .. ")",
						vim.log.levels.WARN
					)
				end
			end

			---@type opencode.Opts
			vim.g.opencode_opts = {
				server = {
					url = url,
					password = password,
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
