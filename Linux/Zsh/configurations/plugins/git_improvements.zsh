# =========================================================================== #
# `git` - newest Git version
# --------------------------
# https://github.com/git/git
# ---
# NOTE:
# Requires:
# - build-essential
# - make
# - libssl-de
# - iubghc-zlib-dev
# - libcurl4-gnutls-dev
# - libexpat1-dev
# - gettext
#  unzip
# =========================================================================== #
# zinit ice \
#	id-as"git" \
#	make"prefix=$ZPFX install"
# zinit load git/git
# if builtin command -v make > /dev/null 2>&1; then
#     zinit wait'0' lucid nocompile \
#         id-as=git as='readurl|command' \
#         mv"%ID% -> git.tar.gz" \
#         atclone'ziextract --move git.tar.gz && \
#         make -j $[$(grep cpu.cores /proc/cpuinfo | sort -u | sed "s/[^0-9]//g") + 1] prefix=$ZPFX all install' \
#         atpull"%atclone" \
#         dlink='/git/git/archive/v%VERSION%.tar.gz' \
#         for https://github.com/git/git/releases/
# fi

# =========================================================================== #
# `git lfs` - Git Large File Storage - extension for versioning large files
# -------------------------------------------------------------------------
# https://git-lfs.github.com/
# https://github.com/git-lfs/git-lfs
# =========================================================================== #
zinit wait lucid \
	id-as"git-lfs" \
	has"git" \
	from"gh-r" \
	atclone"PREFIX=$ZPFX ./install.sh" \
	as"program" \
	for @git-lfs/git-lfs

# =========================================================================== #
# `gh` - GitHub's official command line tool
# ------------------------------------------
# https://github.com/cli/cli/
# =========================================================================== #
zinit wait lucid \
	id-as"github-cli" \
	has"git" \
	from"gh-r" \
	bpick"*.tar.gz" \
	mv"gh* -> gh" \
	atclone'./gh/bin/gh completion --shell zsh > gh/_gh; \
		cp gh/share/man/man1/gh* $ZPFX/man/man1' \
	atpull"%atclone" \
	pick"gh/bin/gh" \
	as"program" \
	for @cli/cli

# =========================================================================== #
# `git-extras` - Git utilities as in extra commands added to `git`
# ----------------------------------------------------------------
# https://github.com/tj/git-extras
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-extras" \
	has"git" \
	make"PREFIX=$ZPFX" \
	pick"$ZPFX/bin/git-*" \
	as"program" \
	src"etc/git-extras-completion.zsh" \
	for @tj/git-extras

# =========================================================================== #
# `git extra commands' - Collection of Git utilities and useful extra scripts
# ---------------------------------------------------------------------------
# https://github.com/unixorn/git-extra-commands
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-extra-commands" \
	has"git" \
	pick"bin/git*" \
	as"program" \
	src"git-extra-commands.plugin.zsh" \
	for @unixorn/git-extra-commands

# =========================================================================== #
# Delta - a viewer for Git and `diff` output
# ------------------------------------------
# https://github.com/dandavison/delta
# =========================================================================== #
zinit wait"1" lucid \
	id-as"detla" \
	has"git" \
	from"gh-r" \
	mv"delta* -> delta" \
	pick"delta/delta" \
	as"program" \
	for @dandavison/delta

# =========================================================================== #
# `git flow` - AVH Edition of the Git extensions to provide high-level
#              repository operations for Vincent Driessen's branching model
# -------------------------------------------------------------------------
# https://nvie.com/posts/a-successful-git-branching-model/
# https://github.com/petervanderdoes/gitflow-avh
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-flow-avh
# =========================================================================== #
zinit wait"1a" lucid \
	id-as"git-flow" \
	has"git" \
	make"prefix=$ZPFX install" \
	pick"$ZPFX/bin/git-flow*" \
	as"program" \
	for @petervanderdoes/gitflow-avh
zinit wait"1b" lucid \
	has"git-flow" \
	for OMZP::git-flow-avh

# =========================================================================== #
# `git-cal` - GitHub like contributions calendar on terminal
# ----------------------------------------------------------
# https://github.com/k4rthik/git-cal
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-cal" \
	has"git" \
	atclone'perl Makefile.PL PREFIX=$ZPFX' \
	atpull'%atclone' \
	make"install" \
	for @k4rthik/git-cal

# =========================================================================== #
# `git-recall` - an interactive way to peruse Git history from the terminal
# -------------------------------------------------------------------------
# https://github.com/Fakerr/git-recall
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-recall" \
	has"git" \
	make"PREFIX=$ZPFX install" \
	for @Fakerr/git-recall

# =========================================================================== #
# `git open` - open the GitHub page or website for a repository in your browser
# -----------------------------------------------------------------------------
# https://github.com/paulirish/git-open
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-open" \
	has"git" \
	if'[[ -v "$DISPLAY" ]]' \
	atclone"mv git-open.1 $ZPFX/man/man1" \
	atpull'%atclone' \
	for @paulirish/git-open

# =========================================================================== #
# `git recent` - see your latest local Git branches, formatted real fancy
# -----------------------------------------------------------------------
# https://github.com/paulirish/git-recent
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-recent" \
	has"git" \
	pick"git-recent" \
	as"program" \
	for @paulirish/git-recent

# =========================================================================== #
# `git my` - Lists a user's remote branches and shows if it was merged and/or
#            available locally
# -----------------------------------------------------------------------
# https://github.com/davidosomething/git-my
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-my" \
	has"git" \
	pick"git-my" \
	as"program" \
	for @davidosomething/git-my

# =========================================================================== #
# `git quick-stats` - Git quick statistics is a simple and efficient way to
#                     access various statistics in Git repository
# -----------------------------------------------------------------------
# https://github.com/davidosomething/git-my
# =========================================================================== #
zinit wait"1" lucid \
	id-as"git-quick-stats" \
	has"git" \
	make"PREFIX=$ZPFX install" \
	for @arzzen/git-quick-stats

# =========================================================================== #
# A utility tool powered by 'fzf' for using Git interactively
# -----------------------------------------------------------
# https://github.com/wfxr/forgit
# =========================================================================== #
zinit wait"1" lucid \
	id-as"forgit" \
	if'[[ -n "$commands[git]" && "$commands[fzf]" ]]' \
	for https://github.com/wfxr/forgit/blob/master/forgit.plugin.zsh

