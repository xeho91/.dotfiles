#compdef pnpm pn
###-begin-pnpm-completion-###
_pnpm_completion() {
  local -a reply dirs values
  reply=("${(@f)$(COMP_CWORD=$((CURRENT-1)) COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" SHELL=zsh pnpm completion-server -- "${words[@]}")}")
  dirs=(${(M)reply:#*/})
  values=(${reply:#*/})
  if (( ${#dirs} )); then
    _describe 'values' dirs -S ''
  fi
  if (( ${#values} )); then
    _describe 'values' values
  fi
}
compdef _pnpm_completion pnpm pn
###-end-pnpm-completion-###
