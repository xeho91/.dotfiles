# =========================================================================== #
# Custom keybindings
# ------------------
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Keymaps
# =========================================================================== #

# Use vi key bindings
bindkey -v

# Bind `Ctrl + o` to kill the whole line forward
bindkey "^o" vi-kill-eol

# Bind `Ctrl + k` to kill the entire line
bindkey "^k" kill-whole-line

