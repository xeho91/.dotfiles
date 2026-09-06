# =========================================================================== #
# GPG - GnuPrivacy Guard
# ----------------------
# https://www.gnupg.org/documentation/manpage.html
# =========================================================================== #
if (( $+commands[gpg-connect-agent] )) && [[ -t 0 ]]; then
	export GPG_TTY="$(tty)"
	command gpg-connect-agent updatestartuptty /bye >/dev/null
fi
