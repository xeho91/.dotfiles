# macOS Bootstrap

Bring up and tear down my macOS development environment.

## Install

> [!CAUTION]
> **Review the script firstly!**
>
> ```sh
> curl -fsSL https://raw.githubusercontent.com/xeho91/.dotfiles/main/os/macos/install.sh | less
> ```

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xeho91/.dotfiles/main/os/macos/install.sh)"
```

### Options

| Flag | Description |
| --- | --- |
| `-h, --help` | Show help |
| `-n, --dry-run` | Print every action without executing it |

### What It Does?

1. Installs prerequisites via [Homebrew] _(formulae + casks)_
2. Replaces macOS Spotlight with [Raycast] <kbd>⌘</kbd> <kbd>Space</kbd>
3. Clones the `.dotfiles` repository into`~/.dotfiles`
4. Bootstraps [Oh My Zsh] and the custom [Zsh] plugins
5. Links the configuration files into place _(backing up anything it replaces)_
6. Provisions version-pinned CLIs from the [mise] configuration
7. Sets the default login shell to [Zsh]

---

## Uninstall

Removes everything [`install.sh`](#install) added: apps, formulae, app data,
caches, config symlinks, Oh My Zsh + plugins, mise tool versions, and the
`~/.dotfiles` clone. Leaves Homebrew, Xcode Command Line Tools, gpg keys, and
your pre-install backups in place.

> [!CAUTION]
> **Review the script firstly!**
>
> ```sh
> curl -fsSL https://raw.githubusercontent.com/xeho91/.dotfiles/main/os/macos/uninstall.sh | less
> ```
>
> This deletes app data. Sign out of apps where a clean teardown matters.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xeho91/.dotfiles/main/os/macos/uninstall.sh)"
```

[Homebrew]: https://brew.sh/
[Raycast]: https://www.raycast.com/
[Oh My Zsh]: https://ohmyz.sh/
[Zsh]: https://www.zsh.org/
[mise]: https://mise.jdx.dev/
