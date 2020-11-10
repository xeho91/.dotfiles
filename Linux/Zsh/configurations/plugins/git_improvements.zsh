# =========================================================================== #
# Git utilities as in extra commands added to `git`
# -------------------------------------------------
# https://github.com/tj/git-extras
# =========================================================================== #
# zinit ice wait lucid \
#     id-as"git-extras" \
#     as"program" \
#     atclone'mv etc/git-extras-completion.zsh etc/_git-extras' \
#     atpull'%atclone' \
#     make"PREFIX=$ZPFX" \
#     pick"$ZPFX/bin/git-*"
# zinit light tj/git-extras

# =========================================================================== #
# `gh` - GitHub's official command line tool
# ------------------------------------------
# https://github.com/cli/cli/
# =========================================================================== #
# zinit ice \
#     id-as"github-cli" \
#     as"program" \
#     from"gh-r" \
#     bpick"*.tar.gz" \
#     mv"gh* -> gh" \
#     atclone'bin/gh completion --shell zsh > gh/_gh \
#         cp gh/share/man/man1/gh* $ZPFX/polaris/share/man/man1' \
#     atpull'%atclone' \
#     pick"gh/bin/gh"
# zinit load cli/cli

# =========================================================================== #
# A utility tool powered by 'fzf' for using Git interactively
# -----------------------------------------------------------
# https://github.com/wfxr/forgit
# =========================================================================== #
# zinit light wfxr/forgit

# =========================================================================== #
# Better, human readable Git diffs
# --------------------------------
# https://github.com/zdharma/zsh-diff-so-fancy
# =========================================================================== #
# zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
# zinit load zdharma/zsh-diff-so-fancy

