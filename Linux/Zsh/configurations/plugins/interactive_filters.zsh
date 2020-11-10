# =========================================================================== #
# `fzy` - simple, fast fuzzy finder for the terminal
# --------------------------------------------
# https://github.com/jhawthorn/fzy
# =========================================================================== #
zinit ice \
	id-as"fzy" \
	as"program" \
	make"PREFIX=$ZPFX install"
zinit load jhawthorn/fzy

# =========================================================================== #
# `fzf` - command-line fuzzy finder
# ---------------------------------
# https://github.com/junegunn/fzf
# =========================================================================== #
zinit pack"bgn-binary+keys" for fzf

# =========================================================================== #
# `peco` - simplistic interactive filtering tool
# ----------------------------------------------
# https://github.com/peco/peco
# =========================================================================== #
# zinit ice \
#     as"program" \
#     from"gh-r" \
#     mv"peco* -> peco" \
#     pick"peco/peco"
# zinit load peco/peco

