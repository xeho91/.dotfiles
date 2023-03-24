local dap = require "dap"
local dapui = require "dapui"
local widgets = require("dap.ui.widgets")
local osv = require "osv"

dapui.setup()

vim.keymap.set("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Toggle Breakpoint" })

vim.keymap.set("n", "<leader>dc", function()
	dap.continue()
end, { desc = "Continue" })

vim.keymap.set("n", "<leader>do", function()
	dap.step_over()
end, { desc = "Step Over" })

vim.keymap.set("n", "<leader>di", function()
	dap.step_into()
end, { desc = "Step Into" })

vim.keymap.set("n", "<leader>dw", function()
	widgets.hover()
end, { desc = "Widgets" })

vim.keymap.set("n", "<leader>dr", function()
	dap.repl.open()
end, { desc = "Repl" })

vim.keymap.set("n", "<leader>du", function()
	dapui.toggle {}
end, { desc = "Dap UI" })

vim.keymap.set("n", "<leader>ds", function()
	osv.launch { port = 8086 }
end, { desc = "Launch Debugger Server" })

vim.keymap.set("n", "<leader>dd", function()
	osv.run_this()
end, { desc = "Launch Debugger" })
