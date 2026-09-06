# =========================================================================== #
# GPG - GnuPrivacy Guard
# ----------------------
# https://www.gnupg.org/documentation/manpage.html
# =========================================================================== #
if [[ -d "$HOME/.gnupg" ]]; then
	export GPG_TTY=$(tty)

	command gpg-connect-agent updatestartuptty /bye >/dev/null
else
	print -P "%K{yellow}Warning\!%k %F{yellow}There is no GPG configured!%f"
fi
