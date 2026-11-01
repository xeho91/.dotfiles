#compdef fd

autoload -U is-at-least

_fd() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'*--and=[Additional search patterns that need to be matched]:pattern:_default' \
'-d+[Set maximum search depth (default\: none)]:depth:_default' \
'--max-depth=[Set maximum search depth (default\: none)]:depth:_default' \
'--min-depth=[Only show search results starting at the given depth.]:depth:_default' \
'(-d --max-depth --min-depth)--exact-depth=[Only show search results at the exact given depth]:depth:_default' \
'*-E+[Exclude entries that match the given glob pattern]:glob:_default' \
'*--exclude=[Exclude entries that match the given glob pattern]:glob:_default' \
'*-t+[Filter by type\: file (f), directory (d/dir), symlink (l), executable (x), empty (e), socket (s), pipe (p), char-device (c), block-device (b)]:filetype:((file\:""
directory\:""
symlink\:""
block-device\:""
char-device\:""
executable\:"A file which is executable by the current effective user"
empty\:""
socket\:""
pipe\:""))' \
'*--type=[Filter by type\: file (f), directory (d/dir), symlink (l), executable (x), empty (e), socket (s), pipe (p), char-device (c), block-device (b)]:filetype:((file\:""
directory\:""
symlink\:""
block-device\:""
char-device\:""
executable\:"A file which is executable by the current effective user"
empty\:""
socket\:""
pipe\:""))' \
'*-e+[Filter by extension]:ext:_default' \
'*--extension=[Filter by extension]:ext:_default' \
'*-S+[Limit results based on the size of files]:size:_default' \
'*--size=[Limit results based on the size of files]:size:_default' \
'--changed-within=[Filter by file modification time (newer than)]:date|dur:_default' \
'--changed-before=[Filter by file modification time (older than)]:date|dur:_default' \
'-o+[Filter by owning user and/or group]:user:group:_default' \
'--owner=[Filter by owning user and/or group]:user:group:_default' \
'(-l --list-details)--format=[Print results according to template]:fmt:_default' \
'(-l --list-details)*-x+[Execute a command for each search result]:cmd:_default' \
'(-l --list-details)*--exec=[Execute a command for each search result]:cmd:_default' \
'(-x --exec -l --list-details)*-X+[Execute a command with all search results at once]:cmd:_default' \
'(-x --exec -l --list-details)*--exec-batch=[Execute a command with all search results at once]:cmd:_default' \
'--batch-size=[Max number of arguments to run as a batch size with -X]:size:_default' \
'*--ignore-file=[Add a custom ignore-file in '\''.gitignore'\'' format]:path:_files' \
'-c+[When to use colors]:when:((auto\:"show colors if the output goes to an interactive console (default)"
always\:"always use colorized output"
never\:"do not use colorized output"))' \
'--color=[When to use colors]:when:((auto\:"show colors if the output goes to an interactive console (default)"
always\:"always use colorized output"
never\:"do not use colorized output"))' \
'--hyperlink=[Add hyperlinks to output paths]::when:((auto\:"Use hyperlinks only if color is enabled"
always\:"Always use hyperlinks when printing file paths"
never\:"Never use hyperlinks"))' \
'*--ignore-contain=[Ignore directories containing the named entry]:name:_default' \
'-j+[Set number of threads to use for searching & executing (default\: number of available CPU cores)]:num:_default' \
'--threads=[Set number of threads to use for searching & executing (default\: number of available CPU cores)]:num:_default' \
'--max-buffer-time=[Milliseconds to buffer before streaming search results to console]:MAX_BUFFER_TIME:_default' \
'--max-results=[Limit the number of search results]:count:_default' \
'-C+[Change current working directory]:path:_files' \
'--base-directory=[Change current working directory]:path:_files' \
'--path-separator=[Set path separator when printing file paths]:separator:_default' \
'()*--search-path=[Provides paths to search as an alternative to the positional <path> argument]:search-path:_files' \
'(--search-path)--strip-cwd-prefix=[By default, relative paths are prefixed with '\''./'\'' when -x/--exec, -X/--exec-batch, or -0/--print0 are given, to reduce the risk of a path starting with '\''-'\'' being treated as a command line option. Use this flag to change this behavior. If this flag is used without a value, it is equivalent to passing "always"]::when:((auto\:"Use the default behavior"
always\:"Always strip the ./ at the beginning of paths"
never\:"Never strip the ./"))' \
'--gen-completions=[]::GEN_COMPLETIONS:(bash elvish fish powershell zsh)' \
'-H[Search hidden files and directories]' \
'--hidden[Search hidden files and directories]' \
'--no-hidden[Overrides --hidden]' \
'-I[Do not respect .(git|fd)ignore files]' \
'--no-ignore[Do not respect .(git|fd)ignore files]' \
'--ignore[Overrides --no-ignore]' \
'--no-ignore-vcs[Do not respect .gitignore files]' \
'--ignore-vcs[Overrides --no-ignore-vcs]' \
'--no-require-git[Do not require a git repository to respect gitignores. By default, fd will only respect global gitignore rules, .gitignore rules, and local exclude rules if fd detects that you are searching inside a git repository. This flag allows you to relax this restriction such that fd will respect all git related ignore rules regardless of whether you'\''re searching in a git repository or not]' \
'--require-git[Overrides --no-require-git]' \
'--no-ignore-parent[Do not respect .(git|fd)ignore files in parent directories]' \
'--ignore-parent[Overrides --no-ignore-parent]' \
'--no-global-ignore-file[Do not respect the global ignore file]' \
'*-u[Unrestricted search, alias for '\''--no-ignore --hidden'\'']' \
'*--unrestricted[Unrestricted search, alias for '\''--no-ignore --hidden'\'']' \
'-s[Case-sensitive search (default\: smart case)]' \
'--case-sensitive[Case-sensitive search (default\: smart case)]' \
'-i[Case-insensitive search (default\: smart case)]' \
'--ignore-case[Case-insensitive search (default\: smart case)]' \
'(-F --fixed-strings)-g[Glob-based search (default\: regular expression)]' \
'(-F --fixed-strings)--glob[Glob-based search (default\: regular expression)]' \
'--regex[Regular-expression based search (default)]' \
'-F[Treat pattern as literal string instead of regex]' \
'--fixed-strings[Treat pattern as literal string instead of regex]' \
'(-g --glob -F --fixed-strings)--exact[Match the entire filename exactly (literal, non-substring)]' \
'-a[Show absolute instead of relative paths]' \
'--absolute-path[Show absolute instead of relative paths]' \
'--relative-path[Overrides --absolute-path]' \
'(-a --absolute-path)-l[Use a long listing format with file metadata]' \
'(-a --absolute-path)--list-details[Use a long listing format with file metadata]' \
'-L[Follow symbolic links]' \
'--follow[Follow symbolic links]' \
'--no-follow[Overrides --follow]' \
'-p[Search full abs. path (default\: filename only)]' \
'--full-path[Search full abs. path (default\: filename only)]' \
'(-l --list-details)-0[Separate search results by the null character]' \
'(-l --list-details)--print0[Separate search results by the null character]' \
'(-S --size --exact-depth)--prune[Do not traverse into directories that match the search criteria. If you want to exclude specific directories, use the '\''--exclude=…'\'' option]' \
'-1[Limit search to a single result]' \
'(--max-results)-q[Print nothing, exit code 0 if match found, 1 otherwise]' \
'(--max-results)--quiet[Print nothing, exit code 0 if match found, 1 otherwise]' \
'--show-errors[Show filesystem errors]' \
'--one-file-system[By default, fd will traverse the file system tree as far as other options dictate. With this flag, fd ensures that it does not descend into a different file system than the one it started in. Comparable to the -mount or -xdev filters of find(1)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'-V[Print version]' \
'--version[Print version]' \
'::pattern -- the search pattern (a regular expression, unless '\''--glob'\'' is used; optional):_default' \
'*::path -- the root directories for the filesystem search (optional):_files' \
&& ret=0
}

(( $+functions[_fd_commands] )) ||
_fd_commands() {
    local commands; commands=()
    _describe -t commands 'fd commands' commands "$@"
}

if [ "$funcstack[1]" = "_fd" ]; then
    _fd "$@"
else
    compdef _fd fd
fi
