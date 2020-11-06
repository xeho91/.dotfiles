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

### Q: What is the difference _(in prompt)_ between `$`, `#` and `%`?

_Source & credits: https://askubuntu.com/a/706190/1145197_

A: These symbols indicate the user account type you are logged in to.

- **Dollar** sign (`$`) means you are a normal user
- **Hash** (`#`) means you are the system administrator _(root)_
- In the C shell, the prompt ends with a **percentage** sign (`%`)

---

### Q: What is the `dev/null`?

_Source & credits: https://stackoverflow.com/a/10508859/6753652_

A: Is a special filesystem object that discards everything written into it.

---

### Q: What the hell is the `2>&1`?

_Source & credits: https://stackoverflow.com/a/10508859/6753652_

A: Redirect the **standard error** _(stderr - 2)_ to **standard output**
   _(stdin -2)_.

Reminder of File Descriptors:
- 0 - stdin _(**st**andard **in**put)_
- 1 - stdout _(**st**andard **out**put)_
- 2 - stderr - _(**st**andard **err**or)_

---

### Q: What does a single ampersand (`&`) at the end of command do?

_Source & credits: https://unix.stackexchange.com/a/86253/440634_

A: It informs the shell to put the command in the background. You can switch to
   it with `fg` command. This is known as "**job control**" in UNIX.

Is possible to have more than just one jobs. List them with `jobs`.
To switch to specific job ID from the list, use `fg %<id>`.

