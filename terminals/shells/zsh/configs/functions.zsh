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

# =========================================================================== #
# `where $1` ($1 - name of the command) to show:
#  1) the location of the executable file
#  2) and completion if this command have them
# =========================================================================== #
function where() {
	if (( $+commands[$1] )); then
		print -P "%F{blue}Executable file location(s):%f $(which $1)"

		if [[ $_comps[$1] ]]; then
			print -P "%F{magenta}Completion file location(s):%f $(echo $^fpath/$_comps[$1](N))"
		else
			print -P '%F{yellow}This command has no completions installed.%f'
		fi
	else
		print -P '%F{red}The command "$1" does not exist!%f'
	fi
}

# =========================================================================== #
# `palette` - print palette and color codes (for percentage expansion)
# =========================================================================== #
function palette() {
	local colors

	if [[ $1 == "background" || $1 == "bg" ]]; then
		for n in {000..255}; do
			colors+=("%K{$n}   %k%F{$n}$n%f")
		done
	else
		for n in {000..255}; do
			colors+=("%F{$n}$n%f")
		done
	fi

	print -Pc $colors
}


# =========================================================================== #
# Print $PATH content in readable way
# =========================================================================== #
function list-path() {
	echo "$PATH" | tr ":" "\n"
}
