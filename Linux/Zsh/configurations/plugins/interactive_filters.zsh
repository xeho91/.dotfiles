# =========================================================================== #
# `fzy` - simple, fast fuzzy finder for the terminal
# --------------------------------------------------
# https://github.com/jhawthorn/fzy
# https://github.com/Zsh-Packages/fzy
# ---
# NOTE: This tool has no completions
# =========================================================================== #
zinit pack"default" for fzy

# =========================================================================== #
# `fzf` - command-line fuzzy finder
# ---------------------------------
# https://github.com/junegunn/fzf
# https://github.com/Zsh-Packages/fzf
# ---
# NOTE: Completion trigger not working
# =========================================================================== #
zinit \
	has"fd" \
	atload' \
		export FZF_DEFAULT_COMMAND="fd \
			--hidden \
			--follow \
			--exclude \".git\" \
			--exclude \"node_modules\" \
		"; \
		export FZF_DEFAULT_OPTS="\
			--layout=reverse \
			--info=inline \
			--height=50% \
			--multi \
			--border \
			--preview-window=:hidden \
			--preview \"([[ -f {}  ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {}  ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200\" \
			--prompt=\"∼ \" \
			--pointer=\"▶\" \
			--marker=\"✓\" \
			--bind \"?:toggle-preview\" \
			--bind \"ctrl-a:select-all\" \
			--bind \"ctrl-d:deselect-all\" \
			--bind \"ctrl-t:toggle-all\" \
			--bind \"ctrl-r:reload($FZF_DEFAULT_COMMAND)\" \
			--bind \"ctrl-y:execute-silent(echo {+} | pbcopy)\" \
			--bind \"ctrl-e:execute(echo {+} | xargs -o vim)\" \
			--bind \"ctrl-v:execute(code {+})\" \
			--bind \"ctrl-j:preview-page-down\" \
			--bind \"ctrl-k:preview-page-up\" \
		"; \
		export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"; \
		export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"; \
		export FZF_COMPLETION_TRIGGER="@@" \
		' \
	pack"bgn-binary+keys" \
	for fzf

