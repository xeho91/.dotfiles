# =========================================================================== #
# Set the language, localization, and character encoding
# ------------------------------------------------------
# https://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html#tag_002_002
# =========================================================================== #
# NOTE: This value is read by an application, so the it will determine language
# of the user interface
export LANG="en_US.UTF-8"

# =========================================================================== #
# Set messages languages (as LC_MESSAGES) to a multi-valued value
# ---------------------------------------------------------------
# https://www.gnu.org/software/gettext/manual/html_node/The-LANGUAGE-variable.html#The-LANGUAGE-variable
# =========================================================================== #
# NOTE: setting it to `fr:de:en` will use French messages where they exist; if
# not, it will use German messages, and will fall back to English if neither
# German nor French messages are available
export LANGUAGE="en_US:en"

# =========================================================================== #
# Set the default file editor, e.g. to be used when typing `edit` in terminal
# =========================================================================== #
if builtin command -v nvim > /dev/null 2>&1; then
	export EDITOR=nvim
else
	export EDITOR=vim
fi

# =========================================================================== #
# Determine an output filtering command for writing the output to a terminal
# --------------------------------------------------------------------------
# http://manpages.ubuntu.com/manpages/hirsute/en/man1/man.1posix.html#environment%20variables
# =========================================================================== #
export PAGER=less
#
# Set passing default options when running $PAGER or `less` command
export LESS='--raw-control-chars --status-column --tab=4 --window=5 --chop-long-lines'
#
# Allow `less` to preview compressed files (methods gzip, bzip2, zip, compress)
# and otherwise encoded files (support for tar, RPM, nroff, MS-Word and many
# more)
if builtin command -v lesspipe.sh > /dev/null 2>&1; then
	export LESSOPEN="|lesspipe.sh %s"
fi

