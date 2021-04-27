local fn = vim.fn
local api = vim.api
local get_icon = require("icons").get_icon

local galaxyline = require("galaxyline")
local section = galaxyline.section

local colors = require("galaxyline/theme").default
local fileinfo = require("galaxyline/provider_fileinfo")
local vcs = require("galaxyline/provider_vcs")
-- local diagnostic = require("galaxyline/provider_diagnostic")
local extension = require("galaxyline/provider_extensions")
local buffer = require("galaxyline/provider_buffer")
local condition = require("galaxyline/condition")

galaxyline.short_line_list = {"packer"}

local modes = {
	n = {alias = "N", color = colors.fg},
	no = {alias = "N|OPERATOR...", color = colors.fg},
	v = {alias = "V", color = colors.green},
	V = {alias = "V|LINE", color = colors.green},
	[""] = {alias = "V|BLOCK", color = colors.green},
	s = {alias = "S", color = colors.blue},
	S = {alias = "S|LINE", color = colors.blue},
	[""] = {alias = "S|BLOCK", color = colors.blue},
	R = {alias = "R", color = colors.yellow},
	Rv = {alias = "R|VIRTUAL", color = colors.yellow},
	c = {alias = "C", color = colors.violet},
	ce = {alias = "C|EX", color = colors.violet},
	cv = {alias = "C|EX", color = colors.violet},
	i = {alias = "I", color = colors.orange},
	ic = {alias = "I|COMPLETION", color = colors.orange},
	r = {alias = "P|--HIT-ENTER--", color = colors.red},
	rm = {alias = "P|--MORE--", color = colors.red},
	["r?"] = {alias = "P|--CONFIRM--", color = colors.red},
	t = {alias = "T", color = colors.bg},
	["!"] = {alias = "T|SHELL", color = colors.bg}
}

local set_color = function(sectionName, what, color)
	api.nvim_command(
		"highlight Galaxy" .. sectionName .. " gui" .. what .. "=" .. color
	)
end

local create_separator = function(direction)
	return {
		provider = function()
			return get_icon("separator_" .. direction)
		end
	}
end

local separator_left = create_separator("left")
local separator_right = create_separator("right")

-- ----------------------------------------------------------------------------
-- Left
-- ----------------------------------------------------------------------------

-- Vi mode
section.left[1] = {
	ViMode = {
		provider = function()
			local mode = fn.mode()
			local color = modes[mode].color

			set_color("ViMode", "bg", color)
			set_color("SeparatorLeft", "fg", color)
			set_color("SeparatorRight", "fg", color)
			set_color("FileName", "fg", color)
			set_color("FileInfo", "fg", color)
			set_color("Position", "bg", color)

			return modes[mode].alias
		end,
		icon = "  " .. get_icon("keyboard"),
		highlight = {colors.bg}
	}
}
section.left[2] = {
	SeparatorRight = separator_right
}

section.left[3] = {
	FileName = {
		provider = function()
			return fileinfo.get_current_file_name()
		end,
		highlight = {colors.bg}
	}
}

section.left[4] = {
	GitBranch = {
		provider = vcs.get_git_branch,
		icon = get_icon("branch"),
		highlight = {colors.fg, "NONE", "bold"},
		separator = " "
	}
}

section.left[5] = {
	DiffAdded = {
		provider = vcs.diff_add,
		icon = get_icon("added"),
		highlight = {colors.green}
	}
}
section.left[6] = {
	DiffModified = {
		provider = vcs.diff_modified,
		icon = get_icon("modified"),
		highlight = {colors.yellow}
	}
}
section.left[7] = {
	DiffRemoved = {
		provider = vcs.diff_remove,
		icon = get_icon("deleted"),
		highlight = {colors.red}
	}
}

--[[ section.left[8] = {
	DiagnosticError = {
		provider = diagnostic.get_diagnostic_error,
		icon = get_icon("error"),
		highlight = {colors.red}
	}
}

section.left[9] = {
	DiagnosticWarn = {
		provider = diagnostic.get_diagnostic_warn,
		icon = get_icon("warning"),
		highlight = {colors.yellow}
	}
}

section.left[10] = {
	DiagnosticInfo = {
		provider = diagnostic.get_diagnostic_info,
		icon = get_icon("info"),
		highlight = {colors.blue}
	}
}

section.left[11] = {
	DiagnosticHint = {
		provider = diagnostic.get_diagnostic_hint,
		icon = get_icon("hint"),
		highlight = {colors.violet}
	}
} ]]
-- ----------------------------------------------------------------------------
-- Middle
-- ----------------------------------------------------------------------------

section.mid[1] = {
	LSP = {
		provider = function()
			--[[ local diagnostics =
				require("lsp-status/diagnostics")(vim.api.nvim_get_current_buf())
			-- you can highlight predefined group manually
			vim.cmd("hi GalaxyLSPError guifg=red guibg=black gui=NONE") ]]
			return require("lsp-status").status()
		end
	}
}

-- ----------------------------------------------------------------------------
-- Right
-- ----------------------------------------------------------------------------

-- File type
section.right[1] = {
	FileType = {
		provider = function()
			return fileinfo.get_file_icon() .. buffer.get_buffer_filetype() .. " "
		end,
		highlight = {fileinfo.get_file_icon_color, "NONE", "bold"}
	}
}

-- File info
section.right[2] = {
	FileInfo = {
		condition = condition.hide_in_width,
		provider = function()
			return "|" ..
				fileinfo.get_file_encode() ..
					" | " .. fileinfo.get_file_format() .. " | " .. fileinfo.get_file_size()
		end
	}
}

-- Position
section.right[3] = {
	SeparatorLeft = separator_left
}
section.right[4] = {
	Position = {
		provider = function()
			return fileinfo.line_column() ..
				extension.scrollbar_instance() .. fileinfo.current_line_percent()
		end,
		highlight = {colors.bg}
	}
}
