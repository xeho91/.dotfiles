#compdef lazygit

_lazygit() {
    local cur prev
    cur=${words[CURRENT]}
    prev=${words[CURRENT-1]}
    case "$prev" in
        *)
            compadd -- -p --path -f --filter -v --version -d --debug -l --logs --profile -c --config -cd --print-config-dir -ucd --use-config-dir -w --work-tree -g --git-dir -ucf --use-config-file -sm --screen-mode git-arg
            ;;
    esac
}
compdef _lazygit lazygit
