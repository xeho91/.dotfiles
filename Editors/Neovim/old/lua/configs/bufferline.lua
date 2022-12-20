-- https://github.com/akinsho/nvim-bufferline.lua

local vimp = require("vimp")
local get_icon = require("icons").get_icon

require("bufferline").setup({
	options = {
		view = "multiwindow",
		numbers = "both",
		number_style = {"superscript", "subscript"},
		mappings = true,
		buffer_close_icon = get_icon("close"),
		modified_icon = get_icon("modified"),
		close_icon = get_icon("close"),
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is deduplicated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, _, _)
			return "(" .. get_icon("diagnostic") .. count .. ")"
		end,
		-- -- custom_filter = function(buf_number)
		-- 		return true
		-- end,
		show_buffer_close_icons = true,
		show_close_icon = true,
		show_tab_indicators = true,
		persist_buffer_sort = true,
		separator_style = "thick",
		enforce_regular_tabs = true,
		always_show_bufferline = true,
		sort_by = "extension"
	}
})

-- Mappings

-- These commands will navigate through buffers in order regardless of which
-- mode you are using e.g. if you change the order of buffers :bnext and
-- :previous will not respect the custom ordering
vimp.nmap("]b", "<cmd>BufferLineCycleNext<CR>")
vimp.nmap("b]", "<cmd>BufferLineCyclePrev<CR>")

-- These commands will move the current buffer backwards
-- or forwards in the bufferline
vimp.nmap("<leader>bn", "<cmd>BufferLineCycleNext<CR>")
vimp.nmap("<leader>bp", "<cmd>BufferLineCyclePrev<CR>")

-- These commands will sort buffers by directory, language,
-- or a custom criteria
vimp.nmap("<leader>be", "<cmd>BufferLineSortByExtension<CR>")
vimp.nmap("<leader>bd", "<cmd>BufferLineSortByDirectory<CR>")
-- nnorevimp.nmap <silent><myvimp.nmap> :lua require'bufferline'.sort_buffers_by(function (buf_a, buf_b) return buf_a.id < buf_b.id end)<CR>
