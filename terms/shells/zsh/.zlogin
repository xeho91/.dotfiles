# =========================================================================== #
# SSH - Secure Shell
# ------------------
# https://www.openssh.com/manual.html
# =========================================================================== #
# GPG - GnuPrivacy Guard
# ----------------------
# https://www.gnupg.org/documentation/manpage.html
# =========================================================================== #

if [[ -d "$HOME/.ssh" && -d "$HOME/.gnupg" ]]; then
	unset SSH_AGENT_PID

	if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
		export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
	fi

	export GPG_TTY=$(tty)

	command gpg-connect-agent updatestartuptty /bye >/dev/null
else
	print -P "%K{yellow}Warning\!%k %F{yellow}There is no GPG or SSH configured!%f"
fi
