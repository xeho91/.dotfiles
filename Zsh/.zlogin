# Expose the colors variables
autoload colors
colors

# =========================================================================== #
# Random fun distraction
# ----------------------
# https://github.com/shlomif/fortune-mod
# https://github.com/tnalpgge/rank-amateur-cowsay
# =========================================================================== #
if type shuf > /dev/null; then
	cowfile="$(cowsay -l | sed "1 d" | tr ' ' '\n' | shuf -n 1)"
  else
	cowfiles=( $(cowsay -l | sed "1 d") );
	cowfile=${cowfiles[$(($RANDOM % ${#cowfiles[*]}))]}
fi
#
print "$fg[yellow]$(fortune)$reset_color" | cowsay -f "$cowfile"

# =========================================================================== #
# Show uptime of the device
# =========================================================================== #
# Print the uptime
print "$fg[blue]$HOST been $(uptime --pretty) (since: $(uptime --since))"

