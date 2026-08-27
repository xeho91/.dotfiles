# ====================== #
# Preferred applications
# ====================== #

if (( $+commands[nvim] )); then
	export EDITOR="nvim"
else
	export EDITOR="vi"
fi

if (( $+commands[less] )); then
  export PAGER="less"
fi

if (( $+commands[nvim] )); then
	export VISUAL="nvim"
fi
