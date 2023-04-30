#! /bin/bash

ZSHENV_PATH="$HOME/.zshenv"

if [ -e "$ZSHENV_PATH" ]; then
	printf "[SKIPPED]: $ZSHENV_PATH\n"
else
	ln --symbolic "$HOME/.dotfiles/Shells/Zsh/.zshenv" "$ZSHENV_PATH"
	printf "[LINKED] $ZSHENV_PATH\n"
fi

GITCONFIG_PATH="$HOME/.gitconfig"

if [ -e "$GITCONFIG_PATH" ]; then
	printf "[SKIPPED]: $GITCONFIG_PATH\n"
else
	ln --symbolic "$HOME/.dotfiles/Git/.gitconfig" "$GITCONFIG_PATH"
	printf "[LINKED] $GITCONFIG_PATH\n"
fi

GACP_PATH="$HOME/.gacprc.json"

if [ -e "$GACP_PATH" ]; then
	printf "[SKIPPED]: $GACP_PATH\n"
else
	ln --symbolic "$HOME/.dotfiles/Git/.gacprc.json" "$GACP_PATH"
	printf "[LINKED] $GACP_PATH\n"
fi

KITTY_CONF_PATH="$XDF_CONFIG_HOME/kitty/kitty.conf"

if [ -e "$KITTY_CONF_PATH" ]; then
	printf "[SKIPPED]: $KITTY_CONF_PATH\n"
else
	ln --symbolic "$HOME/.dotfiles/Terminal/kitty/kitty.conf" "$KITTY_CONF_PATH"
	printf "[LINKED] $KITTY_CONF_PATH\n"
fi

