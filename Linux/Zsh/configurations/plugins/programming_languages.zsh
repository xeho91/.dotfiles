function install_asdf_plugins() {
	local plugins_list_to_install=( \
		# https://github.com/asdf-vm/asdf-nodejs
		nodejs \
		# https://github.com/danhper/asdf-python
		python \
		# https://github.com/code-lever/asdf-rust
		rust \
		# https://github.com/kennyp/asdf-golang
		golang \
	)
	local installed_plugins=$(asdf plugin list)
	for plugin in $plugins_list_to_install; do
		if [[ "$installed_plugins" != *"$plugin"* ]]; then
			command asdf plugin add $plugin
			print -P "%F{blue}Added plugin for %K{white} $plugin %k anod now installing the latest version...%f"
			if [[ "$plugin" == "nodejs" ]]; then
				bash -c "$ASDF_DATA_DIR/plugins/nodejs/bin/import-release-team-keyring"
			fi
			command asdf install $plugin latest
			command asdf global $plugin latest
			command asdf reshim $plugin
			print -P "%F{green}Finished installing the lastest version with asdf %K{white} $plugin %k%f."
		else
			if [[ "$plugin" == "rust" ]]; then
				zinit \
					as"completion" \
					for https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo
			fi
		fi
	done
}

# =========================================================================== #
# Asdf-vm - Extendable (v)ersion (m)anager for languages tools
# ------------------------------------------------------------
# https://github.com/asdf-vm/asdf
# =========================================================================== #
zinit \
	id-as"asdf" \
	atinit'export ASDF_DATA_DIR="$XDG_CONFIG_HOME/.asdf"; \
		export ASDF_CONFIG_FILE="$ASDF_DATA_DIR/.asdfrc"' \
	src"asdf.sh" \
	atload'install_asdf_plugins; unfunction install_asdf_plugins' \
	for @asdf-vm/asdf

