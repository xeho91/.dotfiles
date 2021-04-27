# ------------------------------------------------------------------ #
# Starship - cross-platform minimal, configurable prompt
# ------------------------------------------------------
# https://github.com/starship/starship
# -----
# USES:
# Rust
# ------------------------------------------------------------------ #
zinit id-as"starship" \
	from"gh-r" \
	if'[[ "$USE_PROMPT" == "starship" ]]' \
	pick"starship" \
	as"program" \
	atload'export STARSHIP_CONFIG="$DOTFILES/Shells/Prompts/.starship.toml"; \
		eval "$(starship init zsh)"' \
	lucid \
	for @starship/starship
# ------------------------------------------------------------------ #
# Powerlevel10k - prompt theme with lots of features
# --------------------------------------------------
# https://github.com/romkatv/powerlevel10k
# -----
# USES:
# Shell
# ------------------------------------------------------------------ #
zinit id-as"powerlevel10k" \
	depth=1 \
	if'[[ "$USE_PROMPT" == "p10k" ]]' \
	for @romkatv/powerlevel10k

# To customize prompt, run `p10k configure`
if [[ -f "$ZSH_CONFIG[PROMPTS_DIR]/.p10k.zsh" ]]; then
	source "$ZSH_CONFIG[PROMPTS_DIR]/.p10k.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of `.zshrc`.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# ------------------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

