# List installed commands with registered completion functions; use --all for all
function zsh-completions() {
	local command completion filepath dir selection row all=false
	local -a rows

	[[ ${1:-} == --all ]] && all=true

	for command in ${(ok)_comps}; do
		$all || (( $+commands[$command] )) || continue

		completion=${_comps[$command]}
		filepath='(dynamic or not found in fpath)'

		for dir in $fpath; do
			if [[ -r "$dir/$completion" ]]; then
				filepath="$dir/$completion"
				break
			fi
		done

		printf -v row '%-28s\t%-24s\t%s' "$command" "$completion" "$filepath"
		rows+=("$row")
	done

	if [[ -t 1 ]] && (( $+commands[fzf] )); then
		selection=$(print -rl -- $rows | fzf \
			--delimiter=$'\t' \
			--header="$(printf '%-28s\t%-24s\t%s' 'PROGRAM' 'COMPLETION' 'FILEPATH')" \
			--preview='
				if [[ -r {3} ]]; then
					if command -v bat >/dev/null; then
						bat --style=numbers --color=always {3}
					else
						sed -n "1,120p" {3}
					fi
				else
					printf "No completion file found (possibly generated dynamically).\n"
				fi
			' \
			--preview-window='down:50%') || return

		[[ -z $selection ]] && return 0

		IFS=$'\t' read -r command completion filepath <<< "$selection"

		command=${command%%[[:space:]]*}
		completion=${completion%%[[:space:]]*}
		printf '%-24s %-24s %s\n' "$command" "$completion" "$filepath"
	else
		printf '%-24s %-24s %s\n' 'PROGRAM' 'COMPLETION' 'FILEPATH'
		printf '%s\n' $rows | while IFS=$'\t' read -r command completion filepath; do
			command=${command%%[[:space:]]*}
			completion=${completion%%[[:space:]]*}
			printf '%-24s %-24s %s\n' "$command" "$completion" "$filepath"
		done
	fi
}
