# =========================================================================== #
# Colorize the `man` pages
# ------------------------
# https://www.howtogeek.com/683134/how-to-display-man-pages-in-color-on-linux/
# =========================================================================== #
function man() {
	autoload -Uz colors
	colors

	# EXPLANATION:
	# LESS_TERMCAP_md - Start bold effect (double-bright)
	# LESS_TERMCAP_me - Stop bold effect
	# LESS_TERMCAP_us - Start underline effect
	# LESS_TERMCAP_ue - Stop underline effect
	# LESS_TERMCAP_so - Start stand-out effect (similar to reverse text)
	# LESS_TERMCAP_se - Stop stand-out effect (similar to reverse text)
	# LESS_TERMCAP_mb - Start blink
	LESS_TERMCAP_md="${fg_bold[cyan]}" \
	LESS_TERMCAP_me="${reset_color}" \
	LESS_TERMCAP_us="${fg_bold[magenta]}" \
	LESS_TERMCAP_ue="${reset_color}" \
	LESS_TERMCAP_so="${fg_bold[white]}${bg[blue]}" \
	LESS_TERMCAP_se="${reset_color}" \
	LESS_TERMCAP_mb="${fg_bold[green]}" \
	command man "$@"
}

