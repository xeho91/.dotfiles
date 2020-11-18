# =========================================================================== #
# Separated from OMZ - a function to open stuff from OMZ plugins
# --------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/functions.zsh
# ---
# NOTE: I improved it with detecting if it's connected to any display output
# =========================================================================== #
function open_command() {
	if [[ -v "$DISPLAY" ]]; then
		local open_cmd
		# define the open command
		case "$OSTYPE" in
			darwin*) open_cmd='open' ;;
			cygwin*) open_cmd='cygstart' ;;
			linux*) [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open' || {
				open_cmd='cmd.exe /c start ""'
							[[ -e "$1"  ]] && { 1="$(wslpath -w "${1:a}")" || return 1 }
						} ;;
				msys*) open_cmd='start ""' ;;
				*) echo "Platform $OSTYPE not supported"
					return 1
					;;
		esac
		# run command
		${=open_cmd} "$@" &>/dev/null
	else
		print -P "%F{red}There's no display to open it!%f"
	fi
}

# =========================================================================== #
# `quote` - pick a random quote from http://www.quotationspage.com/
# --------------------------------------------------------------
# NOTE: Inspired by and borrowed from OMZ plugin:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rand-quote/rand-quote.plugin.zsh
# =========================================================================== #
function quote() {
	emulate -L zsh
	# make the GET request and extract the output
	request=$(curl -s --connect-timeout 2 "http://www.quotationspage.com/random.php" \
		| iconv -c -f ISO-8859-1 -t UTF-8 \
		| grep -m 1 "dt ")
	sentence=$(echo "$request" | sed -e 's/<\/dt>.*//g' -e 's/.*html//g' -e 's/^[^a-zA-Z]*//' -e 's/<\/a..*$//g')
	author=$(echo "$request" | sed -e 's/.*\/quotes\///g' -e 's/<.*//g' -e 's/.*">//g')
	# if request sucessfull, print it
	if [[ -n "$author" && -n "$sentence" ]]; then
		print "${sentence}\n\n-- [${author}]"
	fi
}

# =========================================================================== #
# Colorize the `man` pages
# ------------------------
# https://www.howtogeek.com/683134/how-to-display-man-pages-in-color-on-linux/
# =========================================================================== #
function man() {
	autoload -Uz colors
	colors
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
# `where $1` - ($1 - name of the command) show the location of the executable
#			   file and completion if this command have them
# =========================================================================== #
function where() {
	if (( $+commands[$1] )); then
		print -P "%F{blue}Executable file location:%f $(which $1)"
		if [[ $_comps[$1] ]]; then
			print -P "%F{magenta}Completion file location:%f $(echo $^fpath/$_comps[$1](N))"
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
# `where_zsh` - find the mentioned word ($1) anywhere in Zsh configuration.
#				It can be alias, command, commented word or anything. It will
#				use best available searching tool
# =========================================================================== #
function where_zsh() {
	local searcher_cmd
	if (( $+commands[ag] )); then
		searcher_cmd='ag'
	elif (( $+commands[rg] )); then
			searcher_cmd="rg"
	elif (( $+commands[ack] )); then
		searcher_cmd="ack"
	else
		searcher_cmd="grep"
	fi
	local results
	# Explanation of flags:
	# `-i` - force shell to be interactive
	# `-c` - take the first argument as a command to execute
	# `-x` - equivalent to `--xtrace`
	results="$(zsh -ixc : 2>&1 | $searcher_cmd $1)"
	if [ $results ]; then
		print -P "%F{green}Found in:%f"
		print -l $results | nl | h $1
	else
		print -P "%F{red}It wasn't defined or mentioned anywhere in Zsh configurations.%f"
	fi
}

# function make() {
#     pathpat="(/[^/]*)+:[0-9]+"
#     ccred=$(print -P "%F{red}")
#     ccyellow=$(print -P "%F{yellow}")
#     ccend=$(print -P "%f")
#     command make "$@" 2>&1 | sed -E -e "/[Ee]rror[: ]/ $pathpat $ccred $ccend" -e "/[Ww]arning[: ]/ $pathpat $ccyellow $ccend"
#     return ${PIPESTATUS[0]}
# }

