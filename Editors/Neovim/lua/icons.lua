function get_icon(name)
	local icons = {
		-- Feedback
		error = " ",
		warning = " ",
		info = " ",
		hint = " ",
		success = " ",
		bulb = " ",
		-- Actions
		rename = " ",
		preview = " ",
		diagnostic = " ",
		definition = " ",
		reference = " ",
		close = "",
		-- Git
		branch = " ",
		added = " ",
		removed = " ",
		modified = "● ",
		-- Separators
		separator_left = " ",
		separator_right = " ",
		slant_left = " ◢",
		slant_right = "◣ ",
		line = "║",
		-- Other
		keyboard = " ",
		file=" ",
		caret_right = " ",
		caret_left = " "
	}

	return icons[name]
end

return {get_icon = get_icon}
