if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
    export STARSHIP_CONFIG="$DOTFILES/terms/prompts/starship.toml"
fi


