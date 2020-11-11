# =========================================================================== #
# Random fun distraction
# =========================================================================== #
if type shuf > /dev/null; then
	cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
  else
	cowfiles=( $(cowsay -l | sed "1 d") );
	cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
#
command fortune | cowsay -f "$cowfile" | lolcat -f -r

# =========================================================================== #
# Show the uptime of device
# =========================================================================== #
print -P "$HOST been %F{blue}$(uptime --pretty)%f (since $(uptime --since))." \
	| toilet -f term -F border \

