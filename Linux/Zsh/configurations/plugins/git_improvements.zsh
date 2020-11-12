# =========================================================================== #
# Git utilities as in extra commands added to `git`
# -------------------------------------------------
# https://github.com/tj/git-extras
# =========================================================================== #
zinit ice wait lucid \
	id-as"git-extras" \
	has"git" \
	atpull"%atclone" \
	make"PREFIX=$ZPFX" \
	pick"$ZPFX/bin/git-*" \
	as"program" \
	src"etc/git-extras-completion.zsh"
zinit load tj/git-extras

# =========================================================================== #
# `gh` - GitHub's official command line tool
# ------------------------------------------
# https://github.com/cli/cli/
# =========================================================================== #
zinit ice wait lucid \
	id-as"github-cli" \
	from"gh-r" \
	bpick"*.tar.gz" \
	mv"gh* -> gh" \
	atclone'./gh/bin/gh completion --shell zsh > gh/_gh; \
		cp gh/share/man/man1/gh* $ZPFX/man/man1' \
	atpull"%atclone" \
	pick"gh/bin/gh" \
	as"program"
zinit load cli/cli

# =========================================================================== #
# A utility tool powered by 'fzf' for using Git interactively
# -----------------------------------------------------------
# https://github.com/wfxr/forgit
# =========================================================================== #
zinit ice wait lucid \
	id-as"forgit" \
	has"fzf" \
	atload''
zinit snippet https://github.com/wfxr/forgit/blob/master/forgit.plugin.zsh

# =========================================================================== #
# Better, human readable Git diffs
# --------------------------------
# https://github.com/zdharma/zsh-diff-so-fancy
# ---
# This is not rich as `delta` viewer
# =========================================================================== #
# zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
# zinit load zdharma/zsh-diff-so-fancy

# =========================================================================== #
# Delta - a viewer for Git and `diff` output
# ----------------------------------------
# https://github.com/dandavison/delta
# =========================================================================== #
zinit ice wait lucid \
	id-as"detla" \
	from"gh-r" \
	mv"delta* -> delta" \
	pick"delta/delta" \
	as"program"
zinit load dandavison/delta

