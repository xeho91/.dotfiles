# =========================================================================== #
# Print a a human readable list of $PATH
# =========================================================================== #
function path() {
	print "$PATH" | tr ":" "\n" | nl
}

