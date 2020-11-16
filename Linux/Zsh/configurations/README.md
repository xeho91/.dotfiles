# Zsh configuration

## Keybinds 

_Official documentation on how to configure them: <http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Keymaps>_

Is possible to preview currently set key binds with this command
```zsh
bindkey
```
where:
- `^` means <kbd>Ctrl</kbd>
- `]^` means <kbd>Alt</kbd>

---

### Keybinds cheatsheet

- <kbd>Ctrl</kbd> + <kbd>t</kbd> - paste the selected files with [`fzf`][fzf] from the current working directory _(`$PWD` or `pwd`)_
- <kbd>Ctrl</kbd> + <kbd>b</kbd> - open [`fzf-marks`][fzf-marks], bookmarks for [`fzf`][fzf]
- <kbd>Ctrl</kbd> + <kbd>g</kbd> - open [`navi`][navi] cheatsheet 
- <kbd>Ctrl</kbd> + <kbd>r</kbd> - open [`history-search-multi-word`][history-search-multi-word]
- <kbd>Alt</kbd> + <kbd>t</kbd> - `cd` into the selected directory with [`fzf`][fzf] from the current working directory _(`$PWD` or `pwd`)_
- <kbd>CtrL</kbd> + <kbd>[</kbd> - enter **vi-mode**\
  More information on the movement in this mode: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode#movement>
- <kbd>Ctrl</kbd> + <kbd>k</kbd> - **delete everything** _(characters)_
- <kbd>Ctrl</kbd> + <kbd>u</kbd> - delete everything **backward** from the cursor position
- <kbd>Ctrl</kbd> + <kbd>o</kbd> - delete everything **forward** from the cursor position







[navi]: https://github.com/denisidoro/navi
[fzf]: https://github.com/junegunn/fzf
[fzf-marks]: https://github.com/urbainvaes/fzf-marks
[history-search-multi-word]: https://github.com/zdharma/history-search-multi-word

