# Dotfiles

zsh, bash, tmux, git, Neovim, herdr, Ghostty. Ubuntu 20.04.

| Path | Installed as |
|---|---|
| `zsh/.zshrc`, `zsh/.zprofile` | `~/.zshrc`, `~/.zprofile` |
| `bash/.bashrc` | `~/.bashrc` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `git/.gitconfig` | `~/.gitconfig` |
| `nvim/.config/nvim` | `~/.config/nvim` |
| `herdr/.config/herdr/config.toml` | `~/.config/herdr/config.toml` |
| `ghostty/.config/ghostty/config` | `~/.config/ghostty/config` |
| `legacy/` | old Vim configs |

## Install

```bash
./install.sh --dry-run
./install.sh
```

Symlinks into `$HOME`; existing files are moved to `<name>.bak.<timestamp>`. Needs nvim >= 0.11, tmux >= 3.0, zsh with Oh My Zsh.

## Secrets

Keep keys in the git-ignored `~/.zshrc.local` and `~/.bashrc.local` (seeded from `*.local.example`).
