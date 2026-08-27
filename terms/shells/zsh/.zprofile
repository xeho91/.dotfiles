# =========================================================================== #
# Display OS & distribution information at login
# =========================================================================== #
if (( $+commands[fastfetch] )); then
	command fastfetch
elif (( $+commands[neofetch] )); then
    command neofetch
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# =========================================================================== #
# Show the uptime of device
# =========================================================================== #
 if (( $+commands[toilet] )); then
	print -P "$HOST been %F{blue}$(uptime --pretty)%f (since $(uptime --since))." \
		| toilet -f term -F border
 fi

if [[ -f "$HOME/.orbstack/shell/init.zsh" ]]; then
    source "$HOME/.orbstack/shell/init.zsh"
fi
