# =========================================================================== #
# Vi mode in interactive command (when typing commands into shell)
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# =========================================================================== #
zinit snippet OMZP::vi-mode

# =========================================================================== #
# `Ctrl + Z` to back to Vim (in backgroung proces) instead of `fg`
# ----------------------------------------------------------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fancy-ctrl-z
# =========================================================================== #
zinit snippet OMZP::fancy-ctrl-z

# =========================================================================== #
# Alias finder
# ------------
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder
# =========================================================================== #
# zinit ice \
#     atload'ZSH_ALIAS_FINDER_AUTOMATIC=true'
# zinit snippet OMZP::alias-finder


# =========================================================================== #
# Alias tips - helps remembering defined aliases
# ----------------------------------------------
# https://github.com/djui/alias-tips
# =========================================================================== #
zinit ice \
	id-as"alias-tips" \
	pick"alias-tips.plugin.zsh" \
	atload'export ZSH_PLUGINS_ALIAS_TIPS_REVEAL=1'
zinit load djui/alias-tips

