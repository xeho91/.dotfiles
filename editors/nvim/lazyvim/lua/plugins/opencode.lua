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

			-- Prefer the newest session rooted at Neovim's cwd or a parent directory.
			local Server = require("opencode.server")
			local Promise = require("opencode.promise")
			local function normalize_directory(path)
				local directory = vim.fs.normalize(vim.uv.fs_realpath(path) or path)
				return directory == "/" and directory or directory:gsub("/+$", "")
			end

			Server.get_sessions = function(server)
				local cwd = normalize_directory(vim.fn.getcwd())
				return server:request("/api/session?order=desc&parentID=null", "GET"):next(function(response)
					local sessions = response and response.data or {}
					local matches = {}

					for _, session in ipairs(sessions) do
						local directory = session.location and session.location.directory
						if directory then
							directory = normalize_directory(directory)
							local is_ancestor = cwd == directory
								or directory == "/"
								or cwd:sub(1, #directory + 1) == directory .. "/"
							if is_ancestor then
								table.insert(matches, session)
							end
						end
					end

					table.sort(matches, function(left, right)
						local left_directory = normalize_directory(left.location.directory)
						local right_directory = normalize_directory(right.location.directory)
						if #left_directory ~= #right_directory then
							return #left_directory > #right_directory
						end
						return (left.time and left.time.updated or 0) > (right.time and right.time.updated or 0)
					end)

					return Promise.resolve(matches)
				end)
			end

			local resolve_session = Server.resolve_session
			Server.resolve_session = function(server)
				return resolve_session(server):next(function(session)
					server.request_directory = session.location and session.location.directory
					return Promise.resolve(session)
				end)
			end

			-- Route session-specific requests to the selected session's project.
			local curl = Server.curl
			Server.curl = function(server, ...)
				local directory = server.request_directory
				if not directory or directory == "" then
					return curl(server, ...)
				end

				local getcwd = vim.fn.getcwd
				vim.fn.getcwd = function()
					return directory
				end
				local ok, result = pcall(curl, server, ...)
				vim.fn.getcwd = getcwd

				if not ok then
					error(result)
				end
				return result
			end

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
