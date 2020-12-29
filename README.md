# Dotfiles

<img alt="Icon representing tools - wrench on the left, and screwdriver on the right"
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

_Quote borrowed from [this source](https://medium.com/@webprolific/getting-started-with-dotfiles-43c3602fd789)_

So, in other words, this is a repository which contains my configurations for
the programs in my core tool belt.
:warning: Please be careful if you decide to play with my tools… :wink:

---

## Getting started

The goal is to be able to run the installation without any requirements.
The installer is supposed to take care of everything in advance,
to automate the processes.

### Instructions for Linux

This is the [installer file].
At the moment, it is optimized for the following Linux distributions:

- <img alt="Debian logo" height="12"
       src="https://www.debian.org/logos/openlogo-nd.svg"
  /> Debian
- <img alt="Ubuntu logo" height="12"
       src="https://upload.wikimedia.org/wikipedia/commons/a/ab/Logo-ubuntu_cof-orange-hex.svg"
  /> Ubuntu

[installer file]: ./install.sh

1. Download the installation file with typing the following command in your
   shell \
   `curl -O https://raw.githubusercontent.com/xeho91/.dotfiles/main/install.sh`
2. Use `cat install.sh` to read and inspect the code if you have the knowledge
3. Make the file **executable** by changing ownership with this command `chmod
   700 install.sh`
4. Run this installation file by typing `./install.sh` in your shell
