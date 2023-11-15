return {
	{
		-- https://github.com/Saecki/crates.nvim
		"Saecki/crates.nvim",
		opts = {},
		dependencies = {
			{
				"nvim-lua/plenary.nvim",
			},
		},
		-- stylua: ignore
		keys = {
			{ mode = "n", "<leader>cct", function() return require("crates").toggle() end, expr = true, desc = "Crates - toggle" },
			{ mode = "n", "<leader>ccr", function() return require("crates").reload() end, expr = true, desc = "Crates - reload" },
			--
			{ mode = "n", "<leader>ccc", function() return require("crates").show_crate_popup() end, expr = false, desc = "Crates - show crate" },
			{ mode = "n", "<leader>ccv", function() return require("crates").show_versions_popup() end, expr = false, desc = "Crates - show versions" },
			{ mode = "n", "<leader>ccf", function() return require("crates").show_features_popup() end, expr = false, desc = "Crates - show features" },
			{ mode = "n", "<leader>ccd", function() return require("crates").show_dependencies_popup() end, expr = false, desc = "Crates - show dependencies" },
			---
			{ mode = "n", "<leader>ccu", function() return require("crates").update_crate() end, expr = false, desc = "Crates - update crate" },
			{ mode = "v", "<leader>ccu", function() return require("crates").update_crates() end, expr = false, desc = "Crates - update crates" },
			{ mode = "n", "<leader>ccU", function() return require("crates").upgrade_crate() end, expr = false, desc = "Crates - upgrade crate" },
			{ mode = "v", "<leader>ccU", function() return require("crates").upgrade_crates() end, expr = false, desc = "Crates - upgrade crates" },
			{ mode = "n", "<leader>cca", function() return require("crates").update_all_crates() end, expr = false, desc = "Crates - update all crates" },
			{ mode = "n", "<leader>ccA", function() return require("crates").upgrade_all_crates() end, expr = false, desc = "Crates - upgrade all crates" },
			--
			{ mode = "n", "<leader>cce", function() return require("crates").expand_plain_crate_to_inline_table() end, expr = false, desc = "Crates - expand plain crate into inline table" },
			{ mode = "n", "<leader>ccE", function() return require("crates").extract_crate_into_table() end, expr = false, desc = "Crates - extract crate into table" },
			--
			{ mode = "n", "<leader>ccH", function() return require("crates").open_homepage() end, expr = false, desc = "Crates - open homepage" },
			{ mode = "n", "<leader>ccR", function() return require("crates").open_repository() end, expr = false, desc = "Crates - open repository" },
			{ mode = "n", "<leader>ccD", function() return require("crates").open_documentation() end, expr = false, desc = "Crates - open documentation" },
			{ mode = "n", "<leader>ccC", function() return require("crates").open_crates_io() end, expr = false, desc = "Crates - open crates.io" },
		},
	},
	-- {
	-- 	-- https://github.com/simrat39/rust-tools.nvim
	-- 	"simrat39/rust-tools.nvim",
	-- 	opts = function()
	-- 		local ok, mason_registry = pcall(require, "mason-registry")
	-- 		local adapter ---@type any
	-- 		if ok then
	-- 			-- rust tools configuration for debugging support
	-- 			local codelldb = mason_registry.get_package("codelldb")
	-- 			local extension_path = codelldb:get_install_path() .. "/extension/"
	-- 			local codelldb_path = extension_path .. "adapter/codelldb"
	-- 			local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
	-- 				or extension_path .. "lldb/lib/liblldb.so"
	-- 			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
	-- 		end
	-- 		return {
	-- 			dap = {
	-- 				adapter = adapter,
	-- 			},
	-- 			tools = {
	-- 				on_initialized = function()
	-- 					vim.cmd([[
	-- 						augroup RustLSP
	-- 							autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
	-- 							autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
	-- 							autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
	-- 						augroup END
	-- 					]])
	-- 				end,
	-- 			},
	-- 		}
	-- 	end,
	-- },
}
