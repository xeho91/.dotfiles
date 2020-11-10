# ============================================================================ #
# Zsh Completion System configuration
# -----------------------------------
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Completion-System-Configuration
# ============================================================================ #

# Provide a visual feedback when pressing completion (TAB⇥)
# http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Visual-effects
zstyle ':completion:*' format '%U%B%F{magenta}Possible completions for "%f%u%K{black}%d%k%U%F{magenta}":%u%f%b'

# Try filename completion as a default when other completions failed
# http://zsh.sourceforge.net/FAQ/zshfaq04.html
zstyle ':completion:*' completer _complete _ignored _files

# When running `compinstall` again, it lets `compinstall` find where it has
# written out `zstyle` statements last time. This way, is possible to run
# `compinstall` again to update them.
zstyle :compinstall filename '$DOTFILES/Zsh/.zshrc'

# Try to complete every partial directory name in the path entered and not just
# the first one
zstyle ':completion:*' list-suffixes true

# When there are two dirs 'nm' and 'node_modules' and with typing 'nm',
# it will never try to complete it to the latter
zstyle ':completion:*' accept-exact-dirs true

# Partial completion
# Typing 'cd /u/lo/b<TAB⇥>' becomes '/usr/local/bin'
# Typing 'cd ~/L/P/B<TAB⇥>' becomes '~/Library/Preferences/ByHost'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' expand prefix suffix 