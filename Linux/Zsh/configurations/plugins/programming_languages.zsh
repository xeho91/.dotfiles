# =========================================================================== #
# Asdf-vm - Extendable (v)ersion (m)anager for languages tools
# ---
# NOTE :One version manager to rule them all.
# ------------------------------------------------------------
# https://github.com/asdf-vm/asdf
# =========================================================================== #
zinit ice wait lucid \
	id-as"asdf" \
	atinit'export ASDF_DATA_DIR="$XDG_CONFIG_HOME/.asdf"; \
		export ASDF_CONFIG_FILE="$ASDF_DATA_DIR/.asdfrc"' \
	src"asdf.sh"
zinit load asdf-vm/asdf

