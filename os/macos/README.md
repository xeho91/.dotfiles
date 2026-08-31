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
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xeho91/.dotfiles/main/os/macos/install.sh)" -- --profile <profile_name>
```

### Options

| Flag | Description |
| --- | --- |
| `-h, --help` | Show help |
| `-n, --dry-run` | Print every action without executing it |
| `-p, --profile <name>` | Install the given [profile](#profiles); defaults to the base one |

### Profiles

| Name | Description |
| --- | --- |
| `personal` | Adds personal tools |
| `work.augustus` | Augustus client tools |

---

## Uninstall

> [!CAUTION]
> **Review the script firstly!**
>
> ```sh
> curl -fsSL https://raw.githubusercontent.com/xeho91/.dotfiles/main/os/macos/uninstall.sh | less
> ```

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/xeho91/.dotfiles/main/os/macos/uninstall.sh)"
```
