function install_asdf_plugins() {
	local plugins_to_install=( \
		# https://github.com/asdf-vm/asdf-nodejs
		# nodejs \
		# https://github.com/danhper/asdf-python
		# python \
		# https://github.com/code-lever/asdf-rust
		# rust \
		# https://github.com/kennyp/asdf-golang
		# golang \
	)

	local installed_plugins=$(asdf plugin list)

	for plugin in $plugins_to_install; do
		if [[ "$installed_plugins" != *"$plugin"* ]]; then
			command asdf plugin add $plugin

			print -P "%F{blue}Added plugin for %K{white} $plugin %k and now installing the latest version...%f"

			if [[ "$plugin" == "nodejs" ]]; then
				bash -c "$ASDF_DATA_DIR/plugins/nodejs/bin/import-release-team-keyring"
			elif [[ "$plugin" == "rust" ]]; then
				zinit id-as"cargo-completion" \
					mv"cargo* -> _cargo" \
					as"completion" \
					for https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo
			fi

			command asdf install $plugin latest
			command asdf global $plugin latest
			command asdf reshim $plugin

			print -P "%F{green}Finished installing the lastest version with asdf %K{white} $plugin %k%f."
		fi
	done
}

# =========================================================================== #
# `asdf` - Asdf-vm - Extendable (v)ersion (m)anager for languages tools
# ---------------------------------------------------------------------
# https://github.com/asdf-vm/asdf
# =========================================================================== #
if "$INSTALL_RUNTIMES"; then
zinit id-as"asdf" \
	atinit'export ASDF_DATA_DIR="$XDG_CONFIG_HOME/.asdf"; \
		export ASDF_CONFIG_FILE="$ASDF_DATA_DIR/.asdfrc";
		export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$ZDOTDIR/.default-python-packages";
		export ASDF_NPM_DEFAULT_PACKAGES_FILE="$ZDOTDIR/.default-npm-packages"' \
	src"asdf.sh" \
	atload'install_asdf_plugins; unfunction install_asdf_plugins' \
	for @asdf-vm/asdf
fi
