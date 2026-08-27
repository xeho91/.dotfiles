# =========================================================================== #
# Terminals
# =========================================================================== #

# Ghostty
if (( $+commands[ghostty] )) && [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi
