# =========================================================================== #
# SSH - Secure Shell
# ------------------
# https://www.openssh.com/manual.html
# https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
# =========================================================================== #
# GPG - GnuPrivacy Guard
# ----------------------
# https://www.gnupg.org/documentation/manpage.html
# https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key
# # =========================================================================== #
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
# Start the `gpg-agent` on session start
if (( $+commands[keychain] )); then
	gpg_pubkey_id=$(command gpg --list-keys --keyid-format=short \
		| grep pub \
		| grep -o -P '(?<=/)[A-Z0-9]{8}'
	)

	eval "$(keychain --eval --agents gpg "$gpg_pubkey_id")"
else
	command gpg-connect-agent updatestartuptty /bye >/dev/null
fi

