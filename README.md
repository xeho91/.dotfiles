# Dotfiles

<img alt="Icon with tools - a wrench on the left and a screwdriver on the right"
     height="200"
     align="right"
     src="https://www.flaticon.com/svg/static/icons/svg/682/682028.svg"
/>
_The icon is borrowed from [Freepik](http://www.freepik.com/)_

## What are the dotfiles?

> **Dotfiles** are used to customize your system.
> The “dotfiles” name is derived from the configuration files in Unix-like
> systems that start with a dot (e.g. `.bash_profile` and `.gitconfig`).
> For normal users, this indicates these are not regular documents,
> and by default are hidden in directory listings.
> For power users, however, **they are a core tool belt**.

_Quote borrowed from [this source]_

[this source]: https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789

So, in other words, this is a repository which contains my configurations for
the programs in my core tool belt.

---

## Getting started

The goal is to be able to run the installation without any requirements.
The installer is supposed to take care of everything in advance,
to automate the processes.

### Table of Contents

- [<img alt="Linux logo" height="12"
        src="https://upload.wikimedia.org/wikipedia/commons/3/3c/TuxFlat.svg"
  /> Instructions for Linux](#instructions-for-linux)
- [<img alt="Linux logo" height="12"
        src="https://upload.wikimedia.org/wikipedia/commons/4/48/Windows_logo_-_2012_%28dark_blue%29.svg"
  /> Instructions for Windows 10](#instructions-for-windows-10)

---

### Instructions for Linux (CURENNTLY OUTDATED)

[Installer file code - `./Linux/install.sh`](./Linux/install.sh)

<img alt="linux logo"
     height="100"
     align="right"
     src="https://upload.wikimedia.org/wikipedia/commons/3/3c/tuxflat.svg"
/>

:information_source: Currently optimized for these distributions:

- <img alt="Debian logo" height="12"
       src="https://www.debian.org/logos/openlogo-nd.svg"
  /> Debian
- <img alt="Ubuntu logo" height="12"
       src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Logo-ubuntu_cof-orange-hex.svg"
  /> Ubuntu
- <img alt="ArchLinux logo" height="12"
       src="https://upload.wikimedia.org/wikipedia/commons/a/a5/Archlinux-icon-crystal-64.svg"
  /> Arch Linux

### Step by step guide for Linux

1. **Download the installation file.**\
   Type in your shell:

   ```sh
   curl --remote-name "https://raw.githubusercontent.com/xeho91/.dotfiles/main/Linux/install.sh"
   ```

2. **Read and inspect the code.**\
   For example with this command:

   ```sh
   cat install.sh
   ```

   :exclamation: **NOTE**: You can modify the configuration with any text
   editor, if you have the knowledge.\
   _(See the `Variables for installation configuration` section in the
   installer's code, near the beginning of file)_

3. **Make the file executable**.\
   Change the file permissions with one of these two commands:

   ```sh
   chmod 700 install.sh
   # or
   chmod +x install.sh
   ```

4. **Run this installation file.**\
   Type in your shell:

   ```sh
   ./install.sh
   ```

   :exclamation: **NOTE**: Don't forget the `./` at the beginning.
   That's how you run executable files in Linux.

---

### Instructions for Windows 10

[Installer file code - `./Windows/install.ps1`](./Windows/install.ps1)

<img alt="Windows logo"
     height="100"
     align="right"
     src="https://upload.wikimedia.org/wikipedia/commons/4/48/Windows_logo_-_2012_%28dark_blue%29.svg"
/>

### Step by step guide for Windows 10

1. **Run the PowerShell `as administrator`.**

2. **Download the installation file.**\
   Type in your shell:

   ```powershell
   curl --remote-name "https://raw.githubusercontent.com/xeho91/.dotfiles/main/Windows/install.ps1"
   ```

3. **Read and inspect the code.**\
   For example with this command:

   ```powershell
   Get-Content install.ps1
   ```

   :exclamation: **NOTE**: You can modify the configuration with any text
   editor, if you have the knowledge.\
   _(See the `Variables for installation configuration` section in the
   installer's code, near the beginning of file)_

4. **Run this installation file.**\
   Type in your shell:

   ```powershell
   .\install.ps1
   ```

   :exclamation: **NOTE**: Don't forget the `.\` at the beginning.
   That's how you run executable files in Windows.
