# Vim configuration files

This directory contains configuration for editors related to UNIX text editor `vi`.

**WARNING** I have switched to Neovim recently, I am keeping this folder as
backup of my old Vim configuration.

---

## How to profile/inspect what slows down Vim?

Inspect startup log file by starting (Neo)Vim with this flag `--startuptime`
```sh
nvim --startuptime <filename.log>

```
or in the editor run these commands:
```viml
:profile start profile.log
:profile func *
:profile file *
" At this point do the actions which slows down the editor
:profile pause
:noautocmd qall!
```
**NOTE**: At the bottom (tail) there will be a summary of which functions slows
down the editor.

---

## Learning resources

1. https://learnvimscriptthehardway.stevelosh.com/
2. https://devhints.io/vimscript

---

## Learning notes

### Differences between `vim` and `nvim`

https://neovim.io/doc/user/vim_diff.html#'cp'

