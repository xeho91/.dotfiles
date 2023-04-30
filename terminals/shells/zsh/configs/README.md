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

--

## Zinit

A Zsh plugin manager.

_Official documentations:_
- https://zdharma.org/zinit/wiki/
- https://github.com/zdharma/zinit

---

### Learning notes

#### Order of execution for ice modifiers

1. `atinit`
2. `atpull`
3. `make'!!'`
4. `mv`
5. `cp`
6. `make!`
7. `atclone`/`atpull`
8. `make`
9. **(plugin's script loading)**
10. `src`
11. `multisrc`
12. `atload`

---

#### Difference between `light` and `load`

- `zinit load` -> causes reporting to be enabled – you can track what plugin does, view the information with zinit report {plugin-spec} and then also unload the plugin with `zinit unload`

- `zinit light` -> significantly faster loading without tracking and reporting, by using which user resigns of the ability to view the plugin report and to unload information

---

#### Q: How to ensure that the completions are loaded for specific plugin/program?

A: They must start with underscore (`_`) and not have any file extension.
   If they're inside a downloaded package, then we can rename the file with
   completions using `atclone` ice modifier.

_Source: https://github.com/zdharma/zinit/issues/332#issuecomment-626268540_

