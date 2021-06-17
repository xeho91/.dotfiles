# =========================================================================== #
# `navi` - interactive cheatsheet tool for the command-line
#          and application launchers
# ---------------------------------------------------------
# https://github.com/denisidoro/navi
# -----
# USES: Rust Shell
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
if "$IS_RASPBERRYPI" && "$BUILD_FROM_SOURCE"; then
	zinit id-as"navi" \
		has"cargo" \
		make"install \
			SRC_DIR=$ZINIT[PLUGINS_DIR] \
			BIN_DIR=$ZPFX/bin \
			TMP_DIR=$XDG_CACHE_HOME" \
		atload'eval "$(navi widget zsh)";' \
		for @denisidoro/navi
else
	zinit id-as"navi" \
		if'[[ "$USER_MODE" == "developer" ]]' \
		from"gh-r" \
		pick"navi" \
		as"program" \
		atload'eval "$(navi widget zsh)";' \
		for @denisidoro/navi
fi

# =========================================================================== #
# `tldr` - collaborative cheatsheets for console commands
# -------------------------------------------------------
# https://github.com/tldr-pages/tldr
# https://github.com/dbrgn/tealdeer
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"tldr" \
	from"gh-r" \
	mv"tldr* -> tldr" \
	pick"tldr" \
	as"program" \
	wait"0a" lucid \
	for @dbrgn/tealdeer
zinit id-as"tldr-completion" \
	mv"tldr-* -> _tldr" \
	as"completion" \
	wait"0b" lucid \
	for https://github.com/dbrgn/tealdeer/blob/master/zsh_tealdeer

# =========================================================================== #
# `cheat` - create and view interactive cheatsheets on the command-line
# ---------------------------------------------------------------------
# https://github.com/cheat/cheat
# -----
# USES: Golang
# MANPAGE(s): No
# FIXME: Manpages not included in release package, available in repo
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"cheat" \
	from"gh-r" \
	mv"cheat* -> cheat" \
	pick"cheat" \
	as"program" \
	wait"0a" lucid \
	for @cheat/cheat
zinit id-as"cheat-completion" \
	mv"cheat* -> _cheat" \
	as"completion" \
	wait"0b" lucid \
	for https://github.com/cheat/cheat/blob/master/scripts/cheat.zsh

# =========================================================================== #
# `fd` -  simple, fast and user-friendly alternative to `find`
# ------------------------------------------------------------
# https://github.com/sharkdp/fd
# -----
# USES: Rust
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"fd" \
	from"gh-r" \
	mv"fd* -> fd" \
	cp"fd/fd.1 $ZPFX/share/man/man1" \
	pick"fd/fd" \
	as"program" \
	for @sharkdp/fd

# =========================================================================== #
# `ag` - code-searching tool similar to `ack`, but faster
# -------------------------------------------------------
# https://github.com/ggreer/the_silver_searcher
# -----
# USES: C
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"ag" \
	has"automake" \
	atclone' \
		./build.sh; \
		./configure --prefix=$ZPFX; \
	' \
	atpull'%atclone' \
	make'install' \
	pick"$ZPFX/bin/ag" \
	as"program" \
	for @ggreer/the_silver_searcher

# =========================================================================== #
# `rg` - recursively searching directories for a regex pattern with gitignore
# ---------------------------------------------------------------------------
# https://github.com/BurntSushi/ripgrep
# -----
# USES: Rust
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"rg" \
	from"gh-r" \
	mv"rip* -> rg" \
	cp"rg/doc/rg.1 $ZPFX/share/man/man1" \
	pick"rg/rg" \
	as"program" \
	for @BurntSushi/ripgrep

# ========================================================================== #
# `fzy` - simple, fast fuzzy finder for the terminal
# --------------------------------------------------
# https://github.com/jhawthorn/fzy
# https://github.com/Zsh-Packages/fzy
# ---
# USES: C
# MANPAGE(s): Yes
# Completions: No
# =========================================================================== #
zinit \
	if'[[ "$USER_MODE" == "developer" ]]' \
	pack"default" \
	for fzy

# =========================================================================== #
# `fzf` - command-line fuzzy finder
# ---------------------------------
# https://github.com/junegunn/fzf
# https://github.com/Zsh-Packages/fzf
# ---
# USES: Go
# MANPAGE(s): Yes
# Completions: No
# =========================================================================== #
zinit \
	pack"bgn-binary+keys" \
	for fzf

# =========================================================================== #
# A `cat` clone with wings
# ------------------------
# https://github.com/sharkdp/bat
# -----
# USES: Rust
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"bat" \
	from"gh-r" \
	mv"bat* -> bat" \
	cp"bat/bat.1 $ZPFX/share/man/man1" \
	atclone"mv bat/autocomplete/bat.zsh bat/autocomplete/_bat" \
	atpull'%atclone' \
	pick"bat/bat" \
	as"program" \
	for @sharkdp/bat

# =========================================================================== #
# The next generation 'ls' command
# --------------------------------
# https://github.com/Peltoche/lsd
# -----
# USES: Rust
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"lsd" \
	from"gh-r" \
	mv"lsd* -> lsd" \
	cp"lsd/lsd.1 $ZPFX/share/man/man1" \
	pick"lsd/lsd" \
	as"program" \
	for @Peltoche/lsd

# =========================================================================== #
# A next-generation 'cd' command with installed interactive filter
# ----------------------------------------------------------------
# https://github.com/b4b4r07/enhancd
# -----
# USES: Shell
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"enhancd" \
	has"fzf" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	nocompile \
	atinit' \
		export ENHANCD_DIR="$XDG_CACHE_HOME/.enhancd"; \
		export ENHANCD_DISABLE_DOT=1; \
	' \
	atclone'rm -f */*.fish' \
	atpull"%atclone" \
	src"init.sh" \
	for @b4b4r07/enhancd

# =========================================================================== #
# `procs` - a modern replacement for `ps`
# ---------------------------------------
# https://github.com/dalance/procs
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: Yes
# =========================================================================== #
if "$IS_RASPBERRYPI" && "$BUILD_FROM_SOURCE"; then
	zinit id-as"procs" \
		has"cargo" \
		atclone" \
			cargo build --release; \
			./target/release/procs --completion zsh;
		" \
		atpull"%atclone" \
		pick"target/release/procs" \
		as"program" \
		for @dalance/procs
else
	zinit id-as"procs" \
		from"gh-r" \
		bpick"*lnx*" \
		atclone"./procs --completion zsh" \
		atpull"%atclone" \
		pick"procs" \
		as"program" \
		for @dalance/procs
fi

# =========================================================================== #
# `tre` - a modern alternative for `tree`
# ---------------------------------------
# https://github.com/dduan/tre
# -----
# USES: Rust
# MANPAGE(s): Yes
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"tre" \
	from"gh-r" \
	cp"tre.1 $ZPFX/share/man/man1" \
	pick"tre" \
	as"program" \
	atload'tre() { command tre "$@" -e && source "/tmp/tre_aliases_$USER" 2>/dev/null; }' \
	for @dduan/tre

# =========================================================================== #
# `sd` - Intuitive find & replace CLI (sed alternative)
# -----------------------------------------------------
# https://github.com/chmln/sd
# -----
# USES: Rust
# MANPAGE(s): ?
# COMPLETIONS: ?
# FIXME: Currently needs to be build, because there's no proper tar/zip files
# on this program repository in GitHub Releases.
# At the moment is build with cargo default packages on rust runtime install
# =========================================================================== #
#zinit id-as"sd" \
#	from"gh-r" \
#	bpick"*linux-musl" \
#	bpick"sd" \
#	as"program" \
	#for @chmln/sd

# =========================================================================== #
# `dust` - A more intuitive version of Linux `du`
# -----------------------------------------------
# https://github.com/bootandy/dust
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"dust" \
	from"gh-r" \
	mv"dust* -> dust" \
	pick"dust/dust" \
	as"program" \
	for @bootandy/dust


# =========================================================================== #
# `btm` - cross-platform graphical process/system monitor alternative to `top`
# ---------------------------------------------------------------------------
# https://github.com/ClementTsang/bottom
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"btm" \
	from"gh-r" \
	mv"btm* -> btm" \
	pick"btm" \
	as"program" \
	for @ClementTsang/bottom


# =========================================================================== #
# `nnn` (n³) -the unorthodox terminal file manager
# ------------------------------------------------
# https://github.com/jarun/nnn
# ----
# USES: C
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"nnn" \
	make"PREFIX=$ZPFX O_NERD=1 strip install-desktop" \
	pick"nnn" \
	as"program" \
	for @jarun/nnn

# =========================================================================== #
# `exa` - modern replacement for `ls`
# -----------------------------------
# https://github.com/ogham/exa
# ----
# USES: Rust
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"exa" \
	from"gh-r" \
	mv"exa-* -> exa" \
	cp"man/exa.1 -> $ZPFX/share/man/man1" \
	atclone"mv completions/exa.zsh -> completions/_exa" \
	atpull"%atclone" \
	pick"bin/exa" \
	as"program" \
	for @ogham/exa

# =========================================================================== #
# `pet` - simple command line snippet manager
# -------------------------------------------
# https://github.com/knqyf263/pet
# ----
# USES: Go
# MANPAGE(s): No
# COMPLETIONS: Yes
# =========================================================================== #
zinit id-as"pet" \
	has"fzf" \
	from"gh-r" \
	bpick"*.tar.gz" \
	pick"pet" \
	as"program" \
	atload' \
		function prev() { \
			PREV=$(fc -lrn | head -n 1); \
			sh -c "pet new `printf %q "$PREV"`"; \
		}; \
		function pet-select() {
			BUFFER=$(pet search --query "$LBUFFER"); \
			CURSOR=$#BUFFER; \
			zle redisplay; \
		}; \
		zle -N pet-select; \
		stty -ixon; \
		bindkey "^s" pet-select; \
	' \
	for @knqyf263/pet

# =========================================================================== #
# `br` (Broot) - a better way to navigate directories
# ---------------------------------------------------
# https://github.com/Canop/broot
# ----
# USES: Rust
# MANPAGE(s): Yes
# COMPLETIONS: Yes
# NOTE: Requires cargo to build
# =========================================================================== #
#zinit id-as"broot" \
#	for https://dystroy.org/broot/download/

# =========================================================================== #
# `taskwarrior` - CLI task management
# -----------------------------------
# https://github.com/GothenburgBitFactory/taskwarrior
# ----
# USES: ?
# MANPAGE(s): ?
# COMPLETIONS: ?
# =========================================================================== #
#zinit id-as"taskwarrior" \
#	atclone"cmake \
		#-DCMAKE_INSTALL_PREFIX=$ZPFX \
		#-DCMAKE_BUILD_TYPE=release ." \
	#make"install" \
	#wait"1" lucid \
	#for @gothenburgbitfactory/taskwarrior
#zinit id-as"taskwarrior_completion" \
#	has"task" \
#	as"completion" \
#	wait"1" lucid \
#	for https://github.com/GothenburgBitFactory/taskwarrior/blob/2.5.2/scripts/zsh/_task

# =========================================================================== #
# `ruplacer` Find and replace text in source files
# ------------------------------------------------
# https://github.com/dmerejkowsky/ruplacer
# ----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"ruplacer" \
	from"gh-r" \
	mv"ruplacer* -> ruplacer" \
	pick"ruplacer/ruplacer" \
	as"program" \
	for @dmerejkowsky/ruplacer

# =========================================================================== #
# `tokei` - Count the code, quickly
# ---------------------------------
# https://github.com/XAMPPRocky/tokei
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"tokei" \
	from"gh-r" \
	bpick"*linux-musl.tar.gz" \
	pick"tokei" \
	as"program" \
	for @XAMPPRocky/tokei

# =========================================================================== #
# `bandwhich` - Terminal bandwidth utilization tool
# -------------------------------------------------
# https://github.com/imsnif/bandwhich
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"bandwhich" \
	from"gh-r" \
	pick"bandwhich" \
	as"program" \
	for @imsnif/bandwhich

# =========================================================================== #
# `grex` - A command-line tool and library for generating regular expressions
#          from user-provided test cases
# --------------------------------------
# https://github.com/pemistahl/grex
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"grex" \
	from"gh-r" \
	pick"grex" \
	as"program" \
	for @pemistahl/grex

# =========================================================================== #
# `glow` - Render Markdown in the CLI
# -----------------------------------
# https://github.com/charmbracelet/glow
# -----
# USES: Go
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"glow" \
	from"gh-r" \
	mv"glow* -> glow" \
	pick"glow" \
	as"program" \
	for @charmbracelet/glow

# =========================================================================== #
# `zoxide` - A smarter `cd` command
# ---------------------------------
# https://github.com/ajeetdsouza/zoxide
# -----
# USES: Rust
# MANPAGE(s): No
# COMPLETIONS: No
# =========================================================================== #
zinit id-as"zoxide" \
	from"gh-r" \
	mv"zoxide* -> zoxide" \
	pick"zoxide/zoxide" \
	as"program" \
	atload'eval "$(zoxide init zsh --cmd j)"' \
	for @ajeetdsouza/zoxide

# ======================================================================== #
#`wuzz` - interactive tool for HTTP inspection
# ---------------------------------------------
# https://github.com/asciimoo/wuzz
# -----
# USES: Go
# MANPAGE(s): No
# COMPLETIONS: No
# ======================================================================== #
zinit id-as"wuzz" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	from"gh-r" \
	mv"wuzz* -> wuzz" \
	pick"wuzz" \
	as"program" \
	wait lucid \
	for @asciimoo/wuzz

# ======================================================================== #
# `httpstat` - like `curl -v`, with graphs and colors
# ---------------------------------------------------
# https://github.com/b4b4r07/httpstat/blob/master/httpstat.sh
# -----
# USES: Shell
# MANPAGE(s): No
# COMPLETIONS: No
# ======================================================================== #
zinit id-as"httpstat" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	mv"httpstat.sh -> httpstat" \
	atpull"!git reset --hard" \
	pick"httpstat" \
	as"program" \
	wait lucid \
	for @b4b4r07/httpstat

# ======================================================================== #
# `jq` - command-line JSON processor
# ----------------------------------
# https://github.com/stedolan/jq
# -----
# USES: Go
# MANPAGE(s): No
# COMPLETIONS: Yes
# TODO: Fix adding to man pages (They need to be built)
# ======================================================================== #
if "$IS_RASPBERRYPI" && "$BUILD_FROM_SOURCE"; then
	zinit id-as"jq" \
		atclone'autoreconf -i; \
			./configure \
				--prefix=$ZPFX \
				--with-oniguruma=builtin \
				--disable-maintainer-mode' \
		atpull"%atclone" \
		make"install" \
		pick"jq/jq" \
		as"program" \
		for stedolan/jq
else
	zinit id-as"jq" \
		from"gh-r" \
		mv"jq* -> jq" \
		pick"jq/jq" \
		as"program" \
		for stedolan/jq
fi

# ======================================================================= #
# `gh` - GitHub's official command line tool
# ------------------------------------------
# https://github.com/cli/cli/
# -----
# USES: Go
# MANPAGE(s): Yes
# Completion: Yes
# ======================================================================== #
zinit id-as"github-cli" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	from"gh-r" \
	bpick"*.tar.gz" \
	mv"gh* -> gh" \
	cp"gh/share/man/man1/* $ZPFX/share/man/man1/" \
	atclone"./gh/bin/gh completion --shell zsh > gh/_gh" \
	atpull"%atclone" \
	pick"gh/bin/gh" \
	as"program" \
	for @cli/cli

# ======================================================================== #
# Terminal UI for Git's commands
# ------------------------------
# https://github.com/jesseduffield/lazygit
# -----
# USES: Go Shell
# MANPAGE(s): No
# Completion: No
# ======================================================================== #
zinit id-as"lazygit" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	from"gh-r" \
	pick"lazygit" \
	as"program" \
	wait"1" lucid \
	for @jesseduffield/lazygit

# ======================================================================== #
# Delta - a viewer for Git and `diff` output
# ------------------------------------------
# https://github.com/dandavison/delta
# -----
# USES: Rust
# MANPAGE(s): No
# NOTE: Manapge 'delta' exists for different one command
# Completion: No
# NOTE: Completions installed, but they're empty for Zsh
# ======================================================================== #
zinit id-as"delta" \
	has"git" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	from"gh-r" \
	mv"delta* -> delta" \
	pick"delta/delta" \
	as"program" \
	wait"1a" lucid \
	for @dandavison/delta
zinit id-as"delta-completions" \
	has"delta" \
	mv"delta* > _delta" \
	as"completion" \
	wait"1b" lucid \
	for https://github.com/dandavison/delta/blob/master/etc/completion/completion.zsh

# ======================================================================== #
# `dprint` - Pluggable and configurable code formatting platform
# --------------------------------------------------------------
# https://github.com/dprint/dprint
# -----
# USES: Rust
# MANPAGE(s): No
# Completion: No
# ======================================================================== #
zinit id-as"dprint" \
	if'[[ "$USER_MODE" == "developer" ]]' \
	from"gh-r" \
	pick"dprint" \
	as"program" \
	for @dprint/dprint

