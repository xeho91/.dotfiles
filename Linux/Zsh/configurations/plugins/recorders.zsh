# =========================================================================== #
# `asciinema` - terminal session recorder
# ---------------------------------------
# https://github.com/asciinema/asciinema
# =========================================================================== #
zinit ice wait lucid \
	id-as"asciinema" \
	atinit'export PYTHONPATH="$ZPFX/lib/python3.7/site-packages/"' \
	atclone'PYTHONPATH="$ZPFX/lib/python3.7/site-packages/" \
		python3 setup.py --quiet install --prefix $ZPFX' \
	atpull"%atclone" \
	pick"$ZPFX/bin/asciinema" \
	as"program"
zinit load asciinema/asciinema

