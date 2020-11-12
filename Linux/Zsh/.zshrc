# Declare Zsh config associative array with paths to directories
declare -A ZSH_CONFIG

ZSH_CONFIG[HOME_DIR]="$ZDOTDIR/configurations"
ZSH_CONFIG[PLUGINS_DIR]="$ZSH_CONFIG[HOME_DIR]/plugins"
ZSH_CONFIG[PROMPTS_DIR]="$ZSH_CONFIG[HOME_DIR]/prompts"

# Load configurations
source "$ZSH_CONFIG[HOME_DIR]/options.zsh"
source "$ZSH_CONFIG[HOME_DIR]/completions.zsh"
source "$ZSH_CONFIG[HOME_DIR]/plugins.zsh"
source "$ZSH_CONFIG[HOME_DIR]/functions.zsh"
source "$ZSH_CONFIG[HOME_DIR]/aliases.zsh"
source "$ZSH_CONFIG[HOME_DIR]/prompt.zsh"

