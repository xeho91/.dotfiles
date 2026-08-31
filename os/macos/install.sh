#!/usr/bin/env bash

set -euo pipefail

# Restrictive umask:
# anything this script creates (configs, caches, symlink targets, GPG scaffolding)
# should not be readable by other users.
umask 077

# =========================================================================== #
# Configuration
# =========================================================================== #

DOTFILES="${DOTFILES:-"$HOME/.dotfiles"}"
DOTFILES_REPO="${DOTFILES_REPO:-"https://github.com/xeho91/.dotfiles.git"}"
DOTFILES_BRANCH="${DOTFILES_BRANCH:-main}"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Pinned Homebrew installer
# Bump this SHA occasionally: `git ls-remote https://github.com/Homebrew/install.git HEAD`
BREW_INSTALL_SHA="150c69df1e54b0b74c9fcca5a201410a2300816a"
# Prerequisites the installer itself needs and must exist before mise can run
BREW_FORMULAE=(
	"git"
	"mise"
)

# Pinned oh-my-zsh installer
# Bump with `git ls-remote https://github.com/ohmyzsh/ohmyzsh.git HEAD`
OH_MY_ZSH_SHA="a5ecff7560b2e26f612032c632a12c75a3048bd0"
OH_MY_ZSH="$DOTFILES/terms/shells/zsh/ohmyzsh"
OH_MY_ZSH_REPO="https://github.com/ohmyzsh/ohmyzsh.git"
ZSH_CUSTOM_PLUGINS="$OH_MY_ZSH/custom/plugins"

# name|repo|pinned-sha
ZSH_PLUGINS=(
	"fast-syntax-highlighting|https://github.com/zdharma-continuum/fast-syntax-highlighting|3d574ccf48804b10dca52625df13da5edae7f553"
	"fzf-tab|https://github.com/Aloxaf/fzf-tab|24105b15714bfec37989ed5c5b6e60f572253019"
	"zsh-autopair|https://github.com/hlissner/zsh-autopair|449a7c3d095bc8f3d78cf37b9549f8bb4c383f3d"
	"zsh-autosuggestions|https://github.com/zsh-users/zsh-autosuggestions|85919cd1ffa7d2d5412f6d3fe437ebdbeeec4fc5"
	"zsh-completions|https://github.com/zsh-users/zsh-completions|8cd3bd78e8b1f17271cfdd8269074e5557d8d7b8"
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

# =========================================================================== #
# State
# =========================================================================== #

# When set to 1, every action is printed instead of executed
DRY_RUN=0

# Optional mise profile (maps to a mise/config.<name>.toml)
# Empty = base config
PROFILE=""

# Valid values for --profile (must match tools/mise/config.<name>.toml)
KNOWN_PROFILES=(
	"personal"
	"work.augustus"
)

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
	printf "Bootstrap %sxeho91's%s dotfiles on macOS.\n\n" "$CYAN" "$NC"
	printf "Options:\n"
	printf "  %s-n, --dry-run%s   Print every action that would be taken, without executing it.\n" "$YELLOW" "$NC"
	printf "  %s-p, --profile <name>%s  Install the given mise profile (e.g. 'personal');\n" "$YELLOW" "$NC"
	printf "                       defaults to the base config when omitted.\n"
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
# 1. Prerequisites
# =========================================================================== #

bootstrap_xcode_command_line_tools() {
	step "Checking for Xcode Command Line Tools"
	if xcode-select --print-path >/dev/null 2>&1; then
		info "Command Line Tools are installed"
		return
	fi

	warn "Xcode Command Line Tools are missing, launching installer"
	run xcode-select --install

	((DRY_RUN)) && return

	info "Waiting for Command Line Tools installation to complete..."
	local attempts=0
	while ! xcode-select --print-path >/dev/null 2>&1; do
		if pgrep -f "Install Command Line Developer Tools" >/dev/null 2>&1; then
			# Installer dialog/download still active: the clock does not run
			sleep 5
		else
			attempts=$((attempts + 1))
			if ((attempts >= 240)); then
				die "Timed out waiting for Xcode Command Line Tools; run 'xcode-select --install' manually"
			fi
			sleep 5
		fi
	done
}

bootstrap_homebrew() {
	step "Checking for Homebrew (https://brew.sh)"
	if command -v brew >/dev/null 2>&1; then
		info "Homebrew is installed at: $(brew --prefix)"
		return
	fi

	local script_url="https://raw.githubusercontent.com/Homebrew/install/$BREW_INSTALL_SHA/install.sh"
	info "Homebrew is missing, bootstrapping it"

	if ((DRY_RUN)); then
		run curl --proto '=https' --fail --silent --show-error --location "$script_url" "| NONINTERACTIVE=1 bash"
	else
		NONINTERACTIVE=1 /bin/bash -c "$(curl --proto '=https' --fail --silent --show-error --location "$script_url")"
	fi
}

install_brew_prerequisites() {
	step "Installing prerequisites via Homebrew"

	info "Formulae: ${BREW_FORMULAE[*]}"
	run brew install "${BREW_FORMULAE[@]}"

	HOMEBREW_PREFIX="$(brew --prefix)"
	export PATH="$HOMEBREW_PREFIX/bin:$PATH"
}

bootstrap_prerequisites() {
	step "Bootstrap prerequisites"
	[[ "$(uname -s)" == "Darwin" ]] || die "This installer only supports macOS"
	bootstrap_xcode_command_line_tools
	bootstrap_homebrew
	install_brew_prerequisites
}

# =========================================================================== #
# 2. Replace Spotlight with Raycast
# =========================================================================== #

RAYCAST_APP="/Applications/Raycast.app"
RAYCAST_HOTKEY="Command-49"

replace_spotlight_with_raycast() {
	step "Replacing Spotlight with Raycast"

	if ((!DRY_RUN)) && [[ ! -d "$RAYCAST_APP" ]]; then
		warn "Raycast is not installed yet; skipping Spotlight replacement (re-run after the brew step)"
		return
	fi

	info "Disabling the ⌘-Space / ⌃-Space Spotlight shortcuts"
	run defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "{ enabled = 0; }"
	run defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 "{ enabled = 0; }"

	info "Restarting the menu bar services so the change applies"
	run killall SystemUIServer || true

	info "Binding Raycast to ⌘-Space"
	run defaults write com.raycast.macos raycastGlobalHotkey "$RAYCAST_HOTKEY"

	info "Launching Raycast"
	run open -a Raycast
}

# =========================================================================== #
# 3. Dotfiles repository
# =========================================================================== #

clone_dotfiles() {
	step "Fetching dotfiles repository"
	assert_under_home "$DOTFILES"

	if [[ -d "$DOTFILES/.git" ]]; then
		info "Repository already exists, updating it"
		if ((!DRY_RUN)) && [[ -n "$(git -C "$DOTFILES" status --porcelain --untracked-files=no)" ]]; then
			die "dotfiles repo has uncommitted changes; commit or stash them first"
		fi

		run git -C "$DOTFILES" fetch --depth=1 origin "$DOTFILES_BRANCH"
		run git -C "$DOTFILES" reset --hard "origin/$DOTFILES_BRANCH"
		return
	fi

	if [[ -e "$DOTFILES" ]]; then
		die "$DOTFILES exists but is not a git repository. Move it away and re-run"
	fi

	run git clone --depth=1 --branch "$DOTFILES_BRANCH" "$DOTFILES_REPO" "$DOTFILES"
	if ((!DRY_RUN)) && [[ ! -f "$DOTFILES/terms/shells/zsh/zshenv" ]]; then
		die "Clone succeeded but looks wrong: missing terms/shells/zsh/zshenv"
	fi
}

# =========================================================================== #
# 4. Oh My Zsh and plugins
# =========================================================================== #

already_has_zsh() {
	[[ -d "$OH_MY_ZSH/.git" || -f "$OH_MY_ZSH/oh-my-zsh.sh" ]]
}

clone_pinned_zsh_plugins() {
	local repo="$1"
	local sha="$2"
	local target="$3"

	assert_under_home "$target"
	run git init "$target"
	run git -C "$target" remote add origin "$repo"
	run git -C "$target" fetch --depth=1 origin "$sha"
	run git -C "$target" checkout -f FETCH_HEAD
}

clone_oh_my_zsh() {
	step "Bootstrapping Oh My Zsh"

	if already_has_zsh; then
		info "Oh My Zsh is already present at: $OH_MY_ZSH"
		return
	fi

	info "Cloning Oh My Zsh (pinned) into: $OH_MY_ZSH"
	clone_pinned_zsh_plugins "$OH_MY_ZSH_REPO" "$OH_MY_ZSH_SHA" "$OH_MY_ZSH"
}

clone_zsh_plugins() {
	step "Bootstrapping Oh My Zsh plugins"

	if ! already_has_zsh && ((!DRY_RUN)); then
		# Nothing to attach plugins to; let clone_oh_my_zsh handle it
		return
	fi

	run mkdir -p "$ZSH_CUSTOM_PLUGINS"

	for entry in "${ZSH_PLUGINS[@]}"; do
		local name="${entry%%|*}"
		local rest="${entry#*|}"
		local repo="${rest%%|*}"
		local sha="${rest#*|}"
		local target="$ZSH_CUSTOM_PLUGINS/$name"

		if [[ -d "$target" ]]; then
			info "Plugin '$name' is already present"
			continue
		fi

		info "Cloning plugin $name (pinned)"
		clone_pinned_zsh_plugins "$repo" "$sha" "$target"
	done
}

# =========================================================================== #
# 5. Configuration links
# =========================================================================== #

link_file() {
	local src="$1"
	local dst="$2"

	assert_under_home "$dst"

	if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
		info "Already linked: $dst"
		return
	fi

	if [[ -e "$dst" || -L "$dst" ]]; then
		local backup
		backup="$dst.backup-$(date +%Y%m%d-%H%M%S)"
		warn "Backing up $dst to $backup"
		run mv "$dst" "$backup"
	fi

	run ln -s "$src" "$dst"
	info "Linked: $dst -> $src"
}

link_configs() {
	step "Linking configurations"

	assert_under_home "$XDG_CONFIG_HOME"
	run mkdir -p "$XDG_CONFIG_HOME"
	run mkdir -p "$HOME/.gnupg"
	run chmod 700 "$HOME/.gnupg"

	for entry in "${HOME_LINKS[@]}"; do
		link_file "${entry#*|}" "$HOME/${entry%%|*}"
	done

	for entry in "${GNUPG_LINKS[@]}"; do
		link_file "${entry#*|}" "$HOME/.gnupg/${entry%%|*}"
	done

	for entry in "${CONFIG_DIR_LINKS[@]}"; do
		link_file "${entry#*|}" "$XDG_CONFIG_HOME/${entry%%|*}"
	done
}

# =========================================================================== #
# 6. Tools (mise)
# =========================================================================== #

provision_tools() {
	step "Provisioning tools and casks with mise"
	if command -v mise >/dev/null 2>&1 || ((DRY_RUN)); then
		info "Installing Homebrew casks from [bootstrap.packages] (profile: ${MISE_ENV:-base})"
		run mise bootstrap packages apply --yes
		info "Installing version-pinned tools from the mise config (profile: ${MISE_ENV:-base})"
		run mise install
		return
	fi

	warn "mise is not on \$PATH; skipping tool provisioning"
}

# =========================================================================== #
# 7. Default shell
# =========================================================================== #

set_default_shell() {
	step "Setting default login shell to Zsh"

	current_shell=$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $NF}') || current_shell=""
	if [[ "$current_shell" == "/bin/zsh" ]]; then
		info "Login shell is already Zsh."
		return
	fi

	if ((DRY_RUN)); then
		run chsh -s /bin/zsh
		return
	fi

	info "chsh will ask for your password (via the macOS password prompt)"
	if chsh -s /bin/zsh; then
		info "Default shell set to: /bin/zsh"
	else
		warn "Could not set default shell. Run it manually: chsh -s /bin/zsh"
	fi
}

# =========================================================================== #
# Main
# =========================================================================== #

main() {
	while (($#)); do
		case "$1" in
		-n | --dry-run)
			DRY_RUN=1
			shift
			;;
		-p | --profile)
			if (($# < 2)); then
				die "--profile requires a profile name (e.g. --profile personal)"
			fi
			PROFILE="$2"
			shift 2
			;;
		-h | --help)
			usage
			exit 0
			;;
		-*)
			die "Unknown argument: $1 (see --help)"
			;;
		*)
			die "Unknown argument: $1 (see --help)"
			;;
		esac
	done

	if [[ -n "$PROFILE" ]]; then
		local known=0 e
		for e in "${KNOWN_PROFILES[@]}"; do
			if [[ "$e" == "$PROFILE" ]]; then
				known=1
				break
			fi
		done

		if ((!known)); then
			die "Unknown profile: $PROFILE (known: ${KNOWN_PROFILES[*]})"
		fi

		export MISE_ENV="$PROFILE"
	else
		unset MISE_ENV
	fi

	info "Installing dotfiles for $(whoami)@$(hostname)"
	info "Repository: $DOTFILES_REPO ($DOTFILES_BRANCH)"
	info "Mise profile: ${MISE_ENV:-base}"

	if ((DRY_RUN)); then
		warn "DRY RUN: actions below are printed but NOT executed"
	fi

	bootstrap_prerequisites
	replace_spotlight_with_raycast
	clone_dotfiles
	clone_oh_my_zsh
	clone_zsh_plugins
	link_configs
	provision_tools
	set_default_shell

	step "Done!"
	info "Restart your terminal (or run 'exec zsh') to pick up the new configuration"
}

# Run as the entrypoint when executed directly.
# When the script is sourced, only the helpers become available
if [[ -z "${BASH_SOURCE[0]:-}" ]] || [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	main "$@"
fi
