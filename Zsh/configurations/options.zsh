# =========================================================================== #
# Changing directories options
# ----------------------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
# =========================================================================== #
#
# Use the shorthand `~` for `cd ~`
setopt AUTO_CD
#
# Keep a directory stack of all the directories you cd to in a session
setopt AUTO_PUSHD
#
# Push multiple copies of the same directory onto the directory stack
unsetopt PUSHD_IGNORE_DUPS
#
# Use Git-like `-N` instead of the default `+N`
# (e.g. `cd -2` as opposed to `cd +2`)
setopt PUSHD_MINUS

# =========================================================================== #
# Completion options
# ------------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-4
# =========================================================================== #
#
# Move the cursor to the end of the word after accepting a completion
setopt ALWAYS_TO_END
#
# TAB⇥ to show a menu of all completion suggestions. TAB⇥ a second time
# to enter the menu. TAB⇥ again to circulate through the list, or use
# the arrow keys. ENTER to accept a completion from the menu.
setopt AUTO_MENU
#
# If you type TAB⇥ in the middle of a word, the cursor will move to the end
# of the word and zsh will open the completions menu.
# (I.e. type `add`, hit LEFT←, # and then TAB⇥, the cursor will move to
# after the second `d` and completions will be shown for add)
setopt COMPLETE_IN_WORD
#
# Disables the use of ⌃S to stop terminal output and the use of ⌃Q to resume it
unsetopt FLOW_CONTROL
#
# This option prevents the completion menu from showing
# even if AUTO_MENU is set
unsetopt MENU_COMPLETE

# =========================================================================== #
# History options
# ---------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
# =========================================================================== #
#
# Path to zsh's history log file
export HISTFILE=$HOME/.zsh_history
#
# Number of lines or commands that:
# (a) are allowed in the history file at startup time of a session,
# (b) are stored in the history file at the end of your bash session for use
#     in future sessions
export HISTFILESIZE=1000000
#
# Number of commands that are loaded into memory from the history file
export HISTSIZE=1000000
#
# Number of commands that are stored in the zsh history file
export SAVEHIST=1000000
#
# Append to history file instead of overwriting
setopt APPEND_HISTORY
#
# Treat the '!' character specially during expansion
setopt BANG_HIST
#
# Write the history file in the ":start:elapsed;command" format
setopt EXTENDED_HISTORY
#
# Beep when accessing nonexistent history
setopt HIST_BEEP
#
# Expire duplicate entries first when trimming history
setopt HIST_EXPIRE_DUPS_FIRST
#
# Do not display a line previously found
setopt HIST_FIND_NO_DUPS
#
# Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_ALL_DUPS
#
# Don't record an entry that was just recorded again
setopt HIST_IGNORE_DUPS
#
# Don't record an entry starting with a space
setopt HIST_IGNORE_SPACE
#
# Remove superfluous blanks before recording entry
setopt HIST_REDUCE_BLANKS
#
# Don't write duplicate entries in the history file
setopt HIST_SAVE_NO_DUPS
#
# Don't execute immediately upon history expansion
setopt HIST_VERIFY
#
# Write to the history file immediately, not when the shell exits
setopt INC_APPEND_HISTORY
#
# Share history between all sessions
setopt SHARE_HISTORY

# =========================================================================== #
# Input/Output options
# --------------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
# =========================================================================== #
#
# Expand aliases
setopt ALIASES
#
# Try to correct the spelling of commands
setopt CORRECT
#
# Try to correct the spelling of all arguments in a line
# setopt CORRECT_ALL

# =========================================================================== #
# Prompting options
# ----------------
# http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
# =========================================================================== #
#
# Adds support for command substitution
setopt PROMPT_SUBST
