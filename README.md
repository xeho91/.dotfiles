# Dotfiles

My personal dotfiles with saved configurations for tools I use.

---

## Learning notes

### Q: What are "**Environment Variables**"?

_Source: https://likegeeks.com/linux-environment-variables/_

A: They used to store some values which can be used by scripts from the shell.
There are two types of environment variables:
1. [`global variables`](#global)
2. [`local variables`](#local)

### Global

The Linux system sets some global environment variables when you log into your
system, and **they are always CAPITAL LETTERS** to differentiate them from
user-defined environment variables.

To see these global variables, type:
```sh
printenv
```

### Local

The Linux system also defines some standard local environment variables by
default. They're lower case and **withoutspaces**.

To view the global and local variables for the currently running shell and
available to that shell, type:
```sh
set
```

---

### Q: What does the term "`rc`" stands for in file names?

_Source: https://en.wikipedia.org/wiki/Run_commands_

A: Originally, **R**un **C**ommands.

Nowadays, is also adopted as **R**untime **C**onfiguration, for specific
program or tool. The configuration file format starts with dot `.` + `<name of
the program>` + `rc`. Example: `.zshrc`.

---

### Q: What's the difference _(in prompt)_ between `$`, `#` and `%`?

_Source & credits: https://askubuntu.com/a/706190/1145197_

A: These symbols indicate the user account type you are logged in to.

- **Dollar** sign (`$`) means you are a normal user
- **Hash** (`#`) means you are the system administrator _(root)_
- In the C shell, the prompt ends with a **percentage** sign (`%`)

