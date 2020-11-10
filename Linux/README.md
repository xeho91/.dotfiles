# Linux

<img alt="Linux logo" height="100" src="https://upload.wikimedia.org/wikipedia/commons/3/3c/TuxFlat.svg" />

This directory contains configurations for Linux OS tools.

---

## Linux distributions

Distributions I have used so far.

### Debian

<img alt="Debian logo" height="25" src="https://www.debian.org/logos/openlogo-nd.svg" />

_Official documentation: https://www.debian.org/doc/_

### Ubuntu

<img alt="Ubuntu logo" height="25" src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Logo-ubuntu_cof-orange-hex.svg" />

_Official documentation: https://help.ubuntu.com/_

---

## Learning notes

### Linux directory structure

![Linux directory structure](https://linuxhandbook.com/content/images/2020/06/linux-directory-structure.png)

`/` - The **root** directory

- `/bin` - Essential user **bin**aries
- `/boot` - Static **boot** files
- `/dev` - **Dev**ice files
- `/etc` - Configuration files
- `/home` - Home folders for user's personal data
- `/lib` - Essential shared **lib**raries
- `/lost+found` - Recovered files
- `/media` - Removeable **media**
- `/mnt` - Temporary **m**ou**nt** points
- `/opt` - **Opt**ional software _(packages)_
- `/proc` - **Proc**ess and kernel files
- `/root` - The home directory of the user **root**
- `/run` - Application state files
- `/sbin` - **S**ystem administration **bin**aries
- `/srv` - **S**e**rv**ice data
- `/sys` - The file**sys**tem for exporting kernel objects
- `/tmp` - **T**e**mp**orary files
- `/usr` - **Us**e**r** binaries and program data:
  - `/usr/bin` - basic user commands _(binaries)_
  - `/usr/sbin` - additional commands _(binaries)_ for administrators
  - `/usr/lib` - system libraries
  - `/usr/share` - documentations or common to all libraries
- `/var` - **Var**iable data files

_Source & Credits:_
- _https://linuxhandbook.com/linux-directory-structure/_
- _https://www.howtogeek.com/117435/htg-explains-the-linux-directory-structure-explained/_

---

### Q: What is Linux `kernel`?

A: Main component of a Linux operating system _(OS)_ and is the core interface
between a computer’s hardware and its processes. It communicates between the 2,
managing resources as efficiently as possible.

_Source & Credits: https://www.redhat.com/en/topics/linux/what-is-the-linux-kernel_

---

### Q: What are "**Environment Variables**"?

_Debian documentation: https://wiki.debian.org/EnvironmentVariables_
_Ubuntu documentation: https://help.ubuntu.com/community/EnvironmentVariables_

A: They used to store some values which can be used by scripts from the shell.
There are two types of environment variables:
1. [`global variables`](#global)
2. [`local variables`](#local)

#### Global

The Linux system sets some global environment variables when you log into your
system, and **they are always CAPITAL LETTERS** to differentiate them from
user-defined environment variables.

To see these global variables, type:
```sh
printenv
```

#### Local

The Linux system also defines some standard local environment variables by
default. They're lower case and **withoutspaces**.

To view the global and local variables for the currently running shell and
available to that shell, type:
```sh
set
```

_Credits: https://likegeeks.com/linux-environment-variables/_

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

### Q: What is the `/dev/null`?

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
To switch to specific job **id** from the list, use `fg %<id>`.

