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

			-- Pin prompts and commands to the session chosen in the Ctrl-X picker.
			local Server = require("opencode.server")
			if not Server._nvim_session_picker_installed then
				local resolve_session = Server.resolve_session
				Server.resolve_session = function(server)
					local selected_id = vim.g.opencode_selected_session_id
					if not selected_id or selected_id == "" then
						return resolve_session(server)
					end

					return server:get_sessions():next(function(sessions)
						for _, session in ipairs(sessions) do
							if session.id == selected_id then
								return session
							end
						end

						return require("opencode.promise").reject(
							"Selected OpenCode session is not available for "
								.. vim.fn.getcwd()
								.. ". Choose another session with <C-x>."
						)
					end)
				end
				Server._nvim_session_picker_installed = true
			end

			local function select_opencode_session()
				require("opencode.server.discovery")
					.get()
					:next(function(server)
						return server:get_sessions():next(function(sessions)
							if #sessions == 0 then
								vim.notify(
									"No OpenCode sessions found for " .. vim.fn.getcwd(),
									vim.log.levels.WARN,
									{ title = "opencode" }
								)
								return
							end

							vim.ui.select(sessions, {
								prompt = "OpenCode session:",
								format_item = function(session)
									local title = session.title or "Untitled session"
									local selected = session.id == vim.g.opencode_selected_session_id and " [selected]" or ""
									return title .. " — " .. session.id .. selected
								end,
							}, function(session)
								if not session then
									return
								end

								vim.g.opencode_selected_session_id = session.id
								vim.notify(
									"OpenCode session: " .. (session.title or session.id),
									vim.log.levels.INFO,
									{ title = "opencode" }
								)
							end)
						end)
					end)
					:catch(function(err)
						vim.notify(tostring(err), vim.log.levels.ERROR, { title = "opencode" })
					end)
			end

			vim.o.autoread = true

			vim.keymap.set({ "n", "x" }, "<C-a>", function()
				require("opencode").ask("@this: ")
			end, { desc = "Ask OpenCode…" })

			vim.keymap.set({ "n", "x" }, "<C-x>", select_opencode_session, { desc = "Select OpenCode session" })

			vim.keymap.set({ "n", "x" }, "<leader>oa", function()
				require("opencode").select()
			end, { desc = "Select OpenCode action…" })

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
