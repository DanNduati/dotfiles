# Dotfiles

Config for my dev machine (Ubuntu 20.04, zsh + Oh My Zsh, tmux, Neovim).

## Layout

| Path | Installed as |
|---|---|
| `zsh/.zshrc`, `zsh/.zprofile` | `~/.zshrc`, `~/.zprofile` |
| `bash/.bashrc` | `~/.bashrc` |
| `tmux/.tmux.conf` | `~/.tmux.conf` |
| `git/.gitconfig` | `~/.gitconfig` |
| `nvim/.config/nvim/` | `~/.config/nvim` (lazy.nvim, Lua) |
| `herdr/.config/herdr/config.toml` | `~/.config/herdr/config.toml` (herdr, gruvbox theme) |
| `legacy/` | old Vim configs (`init.vim`, `.vimrc`), kept for reference |

## Install

```bash
git clone https://github.com/DanNduati/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh --dry-run   # preview
./install.sh             # symlink into $HOME
```

Existing files are moved to `<name>.bak.<timestamp>`, never deleted, and the script is safe to re-run.
It also checks prerequisites: git, zsh, tmux, nvim >= 0.11, ripgrep, xclip, a C compiler, node, Oh My Zsh with the `zsh-autosuggestions` plugin.
On the first `nvim` launch, plugins, treesitter parsers and language servers install themselves.

## Secrets

Nothing secret is tracked. Put API keys and machine-specific settings in `~/.zshrc.local` and `~/.bashrc.local`
(created by `install.sh` from the `*.local.example` files, mode 600, git-ignored). The rc files source them if present.

## Notes

- **zsh** starts in about 0.3 s: `nvm` and `thefuck` load on first use, `gvm` uses its default environment file and loads fully on first use, `pyenv init` skips the rehash, and PATH is deduplicated.
- **tmux** needs >= 3.0. True colour and a short `escape-time` are set for Neovim, new panes open in the current directory, and copy mode uses vi keys with `xclip`.
- **Neovim** needs >= 0.11 (native `vim.lsp.config`) and starts in about 60 ms: plugins load on demand (keys, commands, `InsertEnter`, first buffer) and `vim.loader` caches compiled Lua. Keymaps are documented in my Obsidian vault.
- Update plugins with `:Lazy sync`; `lazy-lock.json` pins versions, so commit it after updating.
