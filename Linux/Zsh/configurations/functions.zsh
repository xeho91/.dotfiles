# =========================================================================== #
# `ls_path` - print a a human readable list of $PATH
# =========================================================================== #
function ls_path() {
	print -l "${(s<:>)PATH}" | nl
}

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
function quote {
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

