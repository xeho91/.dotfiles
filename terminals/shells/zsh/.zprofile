# =========================================================================== #
# Display OS & distribution information at login
# =========================================================================== #
if (( $+commands[fastfetch] )); then
	command fastfetch
elif (( $+commands[neofetch] )); then
    command neofetch
fi

# =========================================================================== #
# Show the uptime of device
# =========================================================================== #
# if (( $+commands[toilet] )); then
# 	print -P "$HOST been %F{blue}$(uptime --pretty)%f (since $(uptime --since))." \
# 		| toilet -f term -F border
# fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
