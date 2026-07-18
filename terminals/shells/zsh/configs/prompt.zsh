if [[ "$USE_PROMPT" == "starship" ]] && (( $+commands[starship] )); then
    eval "$(starship init zsh)"
    export STARSHIP_CONFIG="$PROMPT_CONFIGS/.starship.toml"
fi


