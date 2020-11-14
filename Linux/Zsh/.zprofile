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
# unset SSH_AGENT_PID
# #
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$  ]; then
#     export SSH_AUTH_SOCK="${HOME}/.gnupg/S.gpg-agent.ssh"
# fi
# export GPG_TTY=$(tty)
# Start the `gpg-agent` and `ssh-agent` on session start
# eval "$(keychain --eval --agents gpg,ssh xeho91_rsa 1A40057D)"
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
command gpg-connect-agent updatestartuptty /bye >/dev/null
