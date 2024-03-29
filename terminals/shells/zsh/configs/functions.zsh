# =========================================================================== #
# Separated from OMZ - a function to open stuff from OMZ plugins
# --------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/functions.zsh
# ---
# NOTE: I improved it with detecting if it's connected to any display output
# =========================================================================== #
function open_command() {
	if [[ -n "$DISPLAY" ]]; then
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
# `random-quote` - pick a random quote from http://www.quotationspage.com/
# --------------------------------------------------------------
# NOTE: Inspired by and borrowed from OMZ plugin:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rand-quote/rand-quote.plugin.zsh
# =========================================================================== #
function random-quote() {
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
# `where-zsh` - find the mentioned word ($1) anywhere in Zsh configuration.
#               It can be alias, command, commented word or anything.
#               It will use best available searching tool.
# =========================================================================== #
function where-zsh() {
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
# Open files with default editor and interactively with `fzf`
# =========================================================================== #
function editor-open-file() {
	command $EDITOR -o $(fzf)
}

# =========================================================================== #
# Use `rga` interactively via `fzf`
# =========================================================================== #
function rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file

	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&

	echo "Opening $file" &&
	xdg-open "$file"
}

# =========================================================================== #
#  Speed up dev with pnpm
# =========================================================================== #
function add-dep() {
    if (( !$+commands[pnpm] )); then
        echo "Command pnpm not found!"
    elif (( !$+commands[git] )); then
        echo "Command git not found!"
    else
        local save="$1"
        local dependency="$2"

        if [[ ! "$save" ]]; then 
            echo "First argument - where to save dependency was not specified!"
            return 1;
        elif [[ ! "$dependency" ]]; then
            echo "Second argument - package name was not specified!"
            return 1;
        elif [[ "$save" == "prod" || "$save" == "peer" || "$save" == "dev" ]]; then
            command pnpm add --save-prod "$dependency"
            command git add "./package.json"
            command git commit --no-verify --message "chore(dependencies): ➕ Add \`$dependency\` to prod"
            return 0;
        else
            echo "$save"
            echo "First argument must be one of these values: prod, peer, dev"
            return 1;
        fi
    fi
}

# =========================================================================== #
#  Speed up updating release notes with Changesets
# =========================================================================== #
function git-changelog() {
    if (( !$+commands[git] )); then
        echo "Command git not found!"
    else
        command git add "./.changeset"
        command git commit --message "chore(Changesets): 🔖 Add release note(s)"
    fi
}

# =========================================================================== #
#  Speed up updating release notes with Changesets
# =========================================================================== #
function git-changelog() {
    if (( !$+commands[git] )); then
        echo "Command git not found!"
    else
        command git add "./.changeset"
        command git commit --message "chore(Changesets): 🔖 Add release note(s)"
    fi
}


# =========================================================================== #
# Print $PATH content in readable way
# =========================================================================== #
function list-path() {
	echo "$PATH" | tr ":" "\n"
}
