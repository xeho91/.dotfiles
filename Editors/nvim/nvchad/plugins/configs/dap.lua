-- https://github.com/mfussenegger/nvim-dap

local dap = require "dap"
local dapui = require "dapui"

--[[ dap.adapters.nlua = function(callback, config) ]]
--[[ 	callback { ]]
--[[ 		type = "server", ]]
--[[ 		host = config.host or "127.0.0.1", ]]
--[[ 		port = config.port or 8086, ]]
--[[ 	} ]]
--[[ end ]]
--[[]]
--[[ dap.configurations.lua = { ]]
--[[ 	{ ]]
--[[ 		type = "nlua", ]]
--[[ 		request = "attach", ]]
--[[ 		name = "Attach to running Neovim instance", ]]
--[[ 	}, ]]
--[[ } ]]

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = {
		os.getenv "HOME"
			.. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js",
	},
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.typescript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.adapters.chrome = {
	type = "executable",
	command = "node",
	args = {
		os.getenv "HOME"
			.. "/path/to/vscode-chrome-debug/out/src/chromeDebug.js",
	}, -- TODO adjust
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.typescriptreact = { -- change to typescript if needed
	{
		type = "chrome",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.adapters.firefox = {
	type = "executable",
	command = "node",
	args = {
		os.getenv "HOME"
			.. "/path/to/vscode-firefox-debug/dist/adapter.bundle.js",
	},
}
--[[]]
--[[ dap.configurations.typescript = { ]]
--[[ 	{ ]]
--[[ 		name = "Debug with Firefox", ]]
--[[ 		type = "firefox", ]]
--[[ 		request = "launch", ]]
--[[ 		reAttach = true, ]]
--[[ 		url = "http://localhost:3000", ]]
--[[ 		webRoot = "${workspaceFolder}", ]]
--[[ 		firefoxExecutable = "/usr/bin/firefox", ]]
--[[ 	}, ]]
--[[ } ]]

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close {}
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close {}
end
