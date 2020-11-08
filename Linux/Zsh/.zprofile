# =========================================================================== #
# GPG - GnuPrivacy Guard
# ----------------------
# https://www.gnupg.org/documentation/manpage.html
# https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key
# =========================================================================== #
# Enable passphrase prompt
export GPG_TTY=$(tty)

# =========================================================================== #
# # SSH - Secure Shell
# --------------------
# https://www.openssh.com/manual.html
# https://help.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh
# =========================================================================== #
# Start the ssh-agent on session start
eval "$(keychain --eval --agents ssh xeho91_rsa)"

