# Zsh (Z Shell)

_Official documentation: http://zsh.sourceforge.net/Doc/_

---

## Learning notes

### Loading order

_Documentation source: http://zsh.sourceforge.net/Doc/Release/Files.html#Startup_002fShutdown-Files_

Loading order for the **Zsh files** with interactive login:
1. [`.zshenv`](#zshenv)
2. [`.zprofile`](#zprofile)
3. [`.zhsrc`](#zshrc)
4. [`.zlogin`](#zlogin)
5. _(after session ends...)_ [`.zlogout`](#zlogout)

### Purpose of each Zsh files

_Documentation source: http://zsh.sourceforge.net/Intro/intro_3.html_

#### `.zshenv`

> _[Read every time]_
>
> This file is always sourced, so it should set environment variables which need
> to be **updated frequently**.
>
> **PATH** _(or its associated counterpart path)_ is a good example because you
> probably don't want to restart your whole session to make it update. By
> setting it in that file, reopening a terminal emulator will start a new Zsh
> instance with the PATH value updated.
>
> But be aware that **this file is read even when Zsh is launched to run a single
> command** _(with the -c option)_, even by another tool like `make`. You should **be
> very careful to not modify the default behavior of standard commands** because it
> may break some tools _(by setting aliases for example)_.

#### `.zprofile`

> _[Read at login]_
>
> I personally treat that file like `.zshenv` but for commands and variables
> which should be set once or which **don't need to be updated frequently**:
> - environment variables to configure tools _(flags for compilation, data folder
> location, etc.)_
> - configuration which execute commands _(like `SCONSFLAGS="--jobs=$((
>   $(nproc) - 1  ))"`)_ as it may take some time to execute.
>
> If you modify this file, you can apply the configuration updates by running a
> login shell:
> ```sh
> exec zsh --login
> ```
>

#### `.zshrc`

> _[Read when interactive]_
>
> I put here everything needed only for **interactive usage**:
>
> - prompt,
> - command completion,
> - command correction,
> - command suggestion,
> - command highlighting,
> - output coloring,
> - aliases,
> - key bindings,
> - commands history management,
> - other miscellaneous interactive tools _(auto_cd, manydots-magic)_...

#### `.zlogin`

> _[Read at login]_
>
> This file is like `.zprofile`, but is read after `.zshrc`. You can consider
> the shell to be fully set up at `.zlogin` execution time.
>
> So, I use it to launch external commands which do not modify shell behaviors
> _(e.g. a login manager)_.

#### `.zlogout`

> _[Read at logout, within login shell]_
>
> Here, you can clear your terminal or any other resource which was setup at
> login.

### **How to choose where to put a setting**

If it...
- ... should be updated on each new shell -> [`.zshenv`](.zshenv)
- ... is needed by a command run non->interactively -> [`.zshenv`](.zshenv)
- ... runs a command which may take some time to complete -> [`.zprofile`](.zprofile)
- ... is related to interactive usage -> [`.zshrc`](.zshrc)
- ... is a command to be run when the shell is fully setup -> [`.zlogin`](.zlogin)
- ... releases a resource acquired at login -> [`.zlogout`](.zlogout)

_Credits for notes above: https://unix.stackexchange.com/a/487889_

---

### What are `.zcompdump` files?

_Documentation source: http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit_

These files are used by Zsh completion system to speed up completion. It's safe
to delete them, but they will be recreated unless `-D` is added to `compinit`
line.

