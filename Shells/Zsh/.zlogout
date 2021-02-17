# =========================================================================== #
# Clear the terminal
# =========================================================================== #
command clear

# =========================================================================== #
# Random fun distraction with quotes and with `boxes`
# =========================================================================== #
if typeset -f quote > /dev/null \
	&& (( $+commands[boxes] && $+commands[lolcat] )); then
		if type shuf > /dev/null; then
			cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
		else
			cowfiles=( $(cowsay -l | sed "1 d") );
			cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
		fi
		quote | cowsay -f "$cowfile" | lolcat -f -r
fi

# =========================================================================== #
# Print what happened
# =========================================================================== #
if (( $+commands[toilet] )); then
	print -P "Logged out from %F{magenta}$HOST%f as %F{magenta}$USER%f." \
		| toilet -f term -F border
fi

