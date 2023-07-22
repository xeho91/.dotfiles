# =========================================================================== #
# Terminals
# =========================================================================== #

# WezTerm
if (( $+commands[wezterm] )); then
	export WEZTERM_CONFIG_FILE="$DOTFILES/terminals/wezterm/wezterm.lua"
fi


# Kitty
# https://sw.kovidgoyal.net/kitty/conf/#kitty-conf
if (( $+commands[kitty] )); then
	export KITTY_CONFIG_DIRECTORY="$DOTFILES/terminals/kitty"
fi
