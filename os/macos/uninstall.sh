#!/usr/bin/env bash

set -euo pipefail

# Restrictive umask: created paths during teardown (e.g. backup dirs) should
# not be world-readable.
umask 077

# =========================================================================== #
# Configuration
# =========================================================================== #

DOTFILES="${DOTFILES:-"$HOME/.dotfiles"}"
DOTFILES_REPO="${DOTFILES_REPO:-"https://github.com/xeho91/.dotfiles.git"}"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# git + mise are installed directly by install.sh; gpg-tui and mole are managed
# by mise [bootstrap.packages]. pinentry-touchid is an aqua tool (removed with
# mise's install dir). Anything here not installed is skipped.
BREW_FORMULAE=(
	"git"
	"gpg-tui"
	"mise"
	"mole"
)
BREW_CASKS=(
	"brave-browser"
	"bruno"
	"ghostty"
	"font-jetbrains-mono-nerd-font"
	"orbstack"
	"proton-drive"
	"proton-mail"
	"proton-pass"
	"protonvpn"
	"raycast"
	"signal"
	"zen"
)

# cask|app-name-to-quit
CASK_APPS=(
	"brave-browser|Brave Browser"
	"bruno|Bruno"
	"ghostty|Ghostty"
	"orbstack|OrbStack"
	"proton-drive|Proton Drive"
	"proton-mail|Proton Mail"
	"proton-pass|Proton Pass"
	"protonvpn|ProtonVPN"
	"raycast|Raycast"
	"signal|Signal"
	"zen|Zen"
)

# Fuzzy tokens: any directory under `$HOME/Library/{...}`
# whose name contains one of these (case-insensitive) is a leftover of an app this script installed.
# Keep tokens specific enough to never match unrelated software.
CLEANUP_TOKENS=(
	"brave"
	"bruno"
	"ghostty"
	"orbstack"
	"proton"
	"raycast"
	"signal"
)

# Explicit leftover paths that the fuzzy sweep cannot express
# (e.g. names that differ from the cask, or dot-prefixed entries)
CLEANUP_PATHS=(
	"$HOME/Library/Caches/Homebrew"
	"$HOME/Library/Logs/Homebrew"
	"$HOME/Library/Application Support/Homebrew"
	"$HOME/Library/Caches/org.zen-browser.app"
	"$HOME/Library/Application Support/zen"
)

# dotname|source
# `$HOME` directory entries
HOME_LINKS=(
	".gitconfig|$DOTFILES/tools/git/gitconfig"
	".zshenv|$DOTFILES/terms/shells/zsh/zshenv"
)

# dotname|source
# File links inside `$HOME/.gnupg`
GNUPG_LINKS=(
	"gpg.conf|$DOTFILES/tools/gnupg/gpg.conf"
	"gpg-agent.conf|$DOTFILES/tools/gnupg/gpg-agent.conf"
)

# dotname|source
# Directory links under `$XDG_CONFIG_HOME`
CONFIG_DIR_LINKS=(
	"bottom|$DOTFILES/tools/bottom"
	"cgrc|$DOTFILES/tools/cgrc"
	"gh|$DOTFILES/tools/gh"
	"ghostty|$DOTFILES/terms/emulators/ghostty"
	"lazygit|$DOTFILES/tools/lazygit"
	"mise|$DOTFILES/tools/mise"
	"nvim|$DOTFILES/editors/nvim/lazyvim"
	"opencode|$DOTFILES/agents/opencode"
	"zellij|$DOTFILES/tools/zellij"
)

ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
MISE_DATA_DIR="${MISE_DATA_DIR:-$HOME/.local/share/mise}"
MISE_CACHE_DIR="${MISE_CACHE_DIR:-$HOME/.cache/mise}"

# =========================================================================== #
# State
# =========================================================================== #

DRY_RUN=0

# =========================================================================== #
# Helpers
# =========================================================================== #

NC=$'\033[0m' # No Color
GREEN=$'\033[0;32m'
YELLOW=$'\033[0;33m'
CYAN=$'\033[0;36m'

info() { printf '%s[ dotfiles ]%s %s\n' "$CYAN" "$NC" "$*"; }
step() { printf '%s==>%s %s\n' "$GREEN" "$NC" "$*"; }
warn() { printf '%s[ warn ]%s %s\n' "$YELLOW" "$NC" "$*" 1>&2; }
die() {
	printf '%s[ fail ]%s %s\n' "$YELLOW" "$NC" "$*" 1>&2
	exit 1
}

usage() {
	printf "Undo %sxeho91's%s macOS bootstrap.\n\n" "$CYAN" "$NC"
	printf "Options:\n"
	printf "  %s-n, --dry-run%s   Print every action that would be taken, without executing it.\n" "$YELLOW" "$NC"
	printf "  %s-h, --help%s      Show this help.\n" "$YELLOW" "$NC"
}

run() {
	if ((DRY_RUN)); then
		printf '%s[dry-run]%s %s\n' "$YELLOW" "$NC" "$*"
		return 0
	fi
	"$@"
}

assert_under_home() {
	local p="$1"
	[[ "$p" == "$HOME"/* ]] || die "Refusing to touch path outside \$HOME: $p"
}

# =========================================================================== #
# 1. Applications (casks)
# =========================================================================== #

# Gracefully quit apps before brew tries to uninstall them
quit_running_apps() {
	step "Quitting running apps"
	for entry in "${CASK_APPS[@]}"; do
		local app="${entry#*|}"
		if pgrep -x "$app" >/dev/null 2>&1; then
			info "Quitting: $app"
			run osascript -e "quit app \"$app\"" || true
		fi
	done
}

uninstall_casks() {
	step "Uninstalling casks (including their data)"

	local missing=()
	for cask in "${BREW_CASKS[@]}"; do
		if ! brew list --cask "$cask" >/dev/null 2>&1; then
			missing+=("$cask")
			continue
		fi

		info "Uninstalling cask: $cask"
		run brew uninstall --zap --cask "$cask" || {
			((DRY_RUN)) || warn "Could not uninstall $cask; continuing"
		}
	done

	if ((${#missing[@]})); then
		info "Skipping casks not installed: ${missing[*]}"
	fi
}

# =========================================================================== #
# 2. Formulae
# =========================================================================== #

uninstall_formulae() {
	step "Uninstalling formulae"

	for formula in "${BREW_FORMULAE[@]}"; do
		if ! brew list --formula "$formula" >/dev/null 2>&1; then
			info "Skipping formula not installed: $formula"
			continue
		fi

		info "Uninstalling formula: $formula"
		run brew uninstall "$formula"
	done

	info "Removing orphaned dependencies"
	run brew autoremove || true

	info "Pruning Homebrew caches and old versions"
	run brew cleanup --prune=all || true
}

# =========================================================================== #
# 3. App leftovers under ~/Library
# =========================================================================== #

remove_app_leavings() {
	step "Removing app data, caches and preferences"

	for path in "${CLEANUP_PATHS[@]}"; do
		assert_under_home "$path"
		if [[ -e "$path" || -L "$path" ]]; then
			info "Removing: $path"
			run rm -rf "$path"
		fi
	done

	local roots=(
		"$HOME/Library/Caches"
		"$HOME/Library/Logs"
		"$HOME/Library/Application Support"
		"$HOME/Library/HTTPStorages"
		"$HOME/Library/Saved Application State"
		"$HOME/Library/WebKit"
		"$HOME/Library/Preferences"
	)

	for root in "${roots[@]}"; do
		assert_under_home "$root"
		[[ -d "$root" ]] || continue

		local name
		for name in "$root"/*; do
			if [[ -e "$name" || -L "$name" ]]; then
				local base="${name##*/}"
				local lc_base
				lc_base="$(printf '%s' "$base" | tr '[:upper:]' '[:lower:]')"

				local token
				for token in "${CLEANUP_TOKENS[@]}"; do
					local lc_token
					lc_token="$(printf '%s' "$token" | tr '[:upper:]' '[:lower:]')"
					if [[ "$lc_base" == *"$lc_token"* ]]; then
						info "Removing leftover: $name"
						run rm -rf "$name"
						break
					fi
				done
			fi
		done
	done
}

# =========================================================================== #
# 4. Spotlight shortcut (restore ⌘-Space/⌃-Space)
# =========================================================================== #

restore_spotlight() {
	step "Restoring Spotlight keyboard shortcuts"

	info "Re-enabling the ⌘-Space / ⌃-Space Spotlight shortcuts"
	run defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-del 64
	run defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-del 65

	info "Removing the Raycast global hotkey"
	run defaults delete com.raycast.macos raycastGlobalHotkey || true

	info "Restarting the menu bar services so the change applies"
	run killall SystemUIServer || true
}

# =========================================================================== #
# 5. Configuration links
# =========================================================================== #

unlink_if_linked() {
	local src="$1"
	local dst="$2"

	assert_under_home "$dst"

	if [[ -L "$dst" ]] && [[ "$(readlink "$dst")" == "$src" ]]; then
		local backups=("$dst".backup-*)
		if [[ -e ${backups[0]} ]]; then
			local newest="${backups[0]}"
			local b
			for b in "$dst".backup-*; do
				if [[ -e "$b" ]] && [[ "$b" -nt "$newest" ]]; then
					newest="$b"
				fi
			done
			warn "Restoring backup: $newest -> $dst"
			run mv "$newest" "$dst"
		else
			info "Removing link: $dst"
			run rm "$dst"
		fi
	fi
}

unlink_configs() {
	step "Removing configuration links"

	for entry in "${HOME_LINKS[@]}"; do
		unlink_if_linked "${entry#*|}" "$HOME/${entry%%|*}"
	done

	for entry in "${GNUPG_LINKS[@]}"; do
		unlink_if_linked "${entry#*|}" "$HOME/.gnupg/${entry%%|*}"
	done

	for entry in "${CONFIG_DIR_LINKS[@]}"; do
		unlink_if_linked "${entry#*|}" "$XDG_CONFIG_HOME/${entry%%|*}"
	done

	info "Keeping ~/.gnupg itself: it holds your gpg keys"
}

# =========================================================================== #
# 6. Dotfiles repository (incl. oh-my-zsh + plugins)
# =========================================================================== #

remove_dotfiles_repo() {
	step "Removing the dotfiles repository"

	if [[ ! -e "$DOTFILES" ]]; then
		info "No repository at: $DOTFILES"
		return
	fi

	info "Removing: $DOTFILES (oh-my-zsh + plugins live inside it)"
	assert_under_home "$DOTFILES"
	run rm -rf "$DOTFILES"
}

# =========================================================================== #
# 7. Tool and shell caches
# =========================================================================== #

remove_tool_caches() {
	step "Removing tool caches and installed tool versions"

	for path in "$ZSH_CACHE_DIR" "$MISE_DATA_DIR" "$MISE_CACHE_DIR"; do
		assert_under_home "$path"
		if [[ -e "$path" || -L "$path" ]]; then
			info "Removing: $path"
			run rm -rf "$path"
		fi
	done
}

# =========================================================================== #
# Main
# =========================================================================== #

main() {
	local arg="${1:-}"

	case "$arg" in
	-n | --dry-run) DRY_RUN=1 ;;
	-h | --help)
		usage
		exit 0
		;;
	"") ;;
	*) die "Unknown argument: $arg (see --help)" ;;
	esac

	info "Uninstalling dotfiles bootstrap for $(whoami)@$(hostname)"

	if ((DRY_RUN)); then
		warn "DRY RUN: actions below are printed but NOT executed"
	fi

	quit_running_apps
	uninstall_casks
	uninstall_formulae
	remove_app_leavings
	restore_spotlight
	unlink_configs
	remove_dotfiles_repo
	remove_tool_caches

	step "Done!"
	info "Left in place: Homebrew, Xcode Command Line Tools, gpg keys, pre-install backups."
}

# Run as the entrypoint when executed directly.
# When the script is sourced, only the helpers become available
if [[ -z "${BASH_SOURCE[0]:-}" ]] || [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	main "$@"
fi
