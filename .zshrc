# FIX for WSL2 with high memory consumption
[ -z "$(ps -ef | grep cron | grep -v grep)"  ] && sudo /etc/init.d/cron start &> /dev/null

# SSH
eval "$(keychain --eval --agents ssh xeho91)"

# GPG - enable passphrase prompt
export GPG_TTY=$(tty)

# Add colors to manual pages ($ man <command>)
# http://www.jedsoft.org/most/
export PAGER="most"

# Configure colors for JQ (JSON) previewer
# In this order: null, false, true, numbers, strings, arrays, objects
export JQ_COLORS="1;30:0;31:0;32:0;33:0;37:1;35:1;36"

# Custom aliases
alias wttr=ShowWeather
alias ls="colorls"
alias open="explorer.exe"

# Custom functions
function ShowWeather { curl -v http://wttr.in/$1 }

# zinit - ZSH plugin manager
# https://github.com/zdharma/zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma.org/zinit/wiki/For-Syntax/
zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/fast-syntax-highlighting \
                zdharma/history-search-multi-word

# Download the default profile

# diff-so-fancy
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zinit load zdharma/zsh-diff-so-fancy

# ====================================================
# asdf-vm - multiple language runtime versions manager
# ====================================================
# https://asdf-vm.com/
#
# Initiate asdf
. $HOME/.asdf/asdf.sh
# Append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# Initialise completions with ZSH's compinit
autoload -Uz compinit
compinit

# =======================================================
# Color LS - colorizes the ls output with color and icons
# =======================================================
# https://github.com/athityakumar/colorls
#
# Enable tab completion for flags
source $(dirname $(gem which colorls))/tab_complete.sh

# =============================
# Starship - cross-shell prompt
# =============================
# https://starship.rs/
# https://github.com/starship/starship
#
# Change Terminal tab title...
function set_terminal_tab_title() {
  # to display current location
  echo -ne "\033]0;\U1F4C2${PWD##*/}\007"
}
# Add it to pre-command functions
precmd_functions+=(set_terminal_tab_title)
# Import settings from...
export STARSHIP_CONFIG=~/.dotfiles/.starship.toml
# Initiate Starship prompt in zsh
eval "$(starship init zsh)"

