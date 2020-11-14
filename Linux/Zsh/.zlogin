# =========================================================================== #
# Display OS & distribution information at login
# =========================================================================== #
if (( $+commands[screenfetch] )); then
	command screenfetch
fi

# =========================================================================== #
# Random fun distraction
# =========================================================================== #
if (( $+commands[fortune] && $+commands[cowsay] && $+commands[lolcat] )); then
	if type shuf > /dev/null; then
		cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
	  else
		cowfiles=( $(cowsay -l | sed "1 d") );
		cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
	fi
	#
	command fortune | cowsay -f "$cowfile" | lolcat -f -r
fi

# =========================================================================== #
# Show the uptime of device
# =========================================================================== #
if (( $+commands[toilet] )); then
	print -P "$HOST been %F{blue}$(uptime --pretty)%f (since $(uptime --since))." \
		| toilet -f term -F border
fi

