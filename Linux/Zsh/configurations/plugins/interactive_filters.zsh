# =========================================================================== #
# `fzy` - simple, fast fuzzy finder for the terminal
# --------------------------------------------
# https://github.com/jhawthorn/fzy
# =========================================================================== #
zinit ice \
	id-as"fzy" \
	make"PREFIX=$ZPFX install"
zinit load jhawthorn/fzy

# =========================================================================== #
# `fzf` - command-line fuzzy finder
# ---------------------------------
# https://github.com/junegunn/fzf
# TODO: Fix completions
# =========================================================================== #
zinit pack"bgn-binary+keys" \
	atload'export FZF_DEFAULT_OPTS="--multi --border --layout=reverse --height=60%"' \
	for fzf
	# atload'export FZF_DEFAULT_OPTS="--multi --border --layout=reverse --height=60%"; \
	#     export FZF_DEFAULT_COMMAND="fd --hidden --follow"' \

# =========================================================================== #
# `peco` - simplistic interactive filtering tool
# ----------------------------------------------
# https://github.com/peco/peco
# =========================================================================== #
# zinit ice \
#     id-as"peco" \
#     from"gh-r" \
#     mv"peco* -> peco" \
#     pick"peco/peco" \
#     as"program"
# zinit load peco/peco

