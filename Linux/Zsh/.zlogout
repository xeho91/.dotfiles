# =========================================================================== #
# Clear the terminal
# =========================================================================== #
command clear

# =========================================================================== #
# Random fun distraction while logging out
# =========================================================================== #
shapes=(\
	bear \
	boy \
	capgirl \
	cat \
	columns \
	diamonds \
	dog \
	face \
	fence \
	girl \
	ian_jones \
	mouse \
	nuke \
	parchment \
	peek \
	santa \
	scroll \
	scroll-akn \
	spring \
	sunset \
	twisted \
	unicornsay \
	unicornthink \
	whirly \
)
shapes_length=${#shapes[@]}
random_index=($((RANDOM % shapes_length))+1)
command fortune | boxes -d "${shapes[$random_index]}" | lolcat -f -r

# =========================================================================== #
# Print what happened
# =========================================================================== #
print -P "Logged out from %F{magenta}$HOST%f as %F{magenta}$USER%f." \
	| toilet -f term -F border

