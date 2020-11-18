# =========================================================================== #
# Clear the terminal
# =========================================================================== #
command clear

# =========================================================================== #
# Random fun distraction while logging out
# =========================================================================== #
if typeset -f quote > /dev/null \
	&& (( $+commands[boxes] && $+commands[lolcat] )); then
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
	quote | fold -sw 80 | boxes -d ${shapes[$random_index]} -a jr | lolcat -f -r
fi

# =========================================================================== #
# Print what happened
# =========================================================================== #
if (( $+commands[toilet] )); then
	print -P "Logged out from %F{magenta}$HOST%f as %F{magenta}$USER%f." \
		| toilet -f term -F border
fi

