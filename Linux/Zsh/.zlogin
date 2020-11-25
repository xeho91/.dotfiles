# =========================================================================== #
# Display OS & distribution information at login
# =========================================================================== #
if (( $+commands[screenfetch] )); then
	command screenfetch
fi

# =========================================================================== #
# Random distraction with hacker laws
# -----------------------------------
# https://github.com/dwmkerr/hacker-laws
# =========================================================================== #
if (( $+commands[hacker-laws-cli] \
	&& $+commands[boxes] \
	&& $+commands[lolcat] \
	)); then
	shapes=(\
		"bear" \
		"boy" \
		"capgirl" \
		"cat" \
		"columns" \
		"diamonds" \
		"dog" \
		"face" \
		"fence" \
		"girl" \
		"ian_jones" \
		"mouse" \
		"nuke" \
		"parchment" \
		"peek" \
		"santa" \
		"scroll" \
		"scroll-akn" \
		"spring" \
		"sunset" \
		"twisted" \
		"unicornsay" \
		"unicornthink" \
		"whirly" \
	)
	shapes_length=${#shapes[@]}
	random_index=($((RANDOM % shapes_length))+1)
	command hacker-laws-cli random | fold -sw 53 \
		|boxes -d ${shapes[$random_index]} | lolcat -f -r
fi

# =========================================================================== #
# Show the uptime of device
# =========================================================================== #
if (( $+commands[toilet] )); then
	print -P "$HOST been %F{blue}$(uptime --pretty)%f (since $(uptime --since))." \
		| toilet -f term -F border
fi

