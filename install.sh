#!/usr/bin/env bash
# Symlink these dotfiles into $HOME.
#   ./install.sh            install
#   ./install.sh --dry-run  show what would change, touch nothing
# Existing files are moved to <name>.bak.<timestamp>, never deleted. Safe to re-run.
set -euo pipefail

DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

run() {
    if (( DRY_RUN )); then echo "  [dry-run] $*"; else "$@"; fi
}

link() { # link <repo-relative source> <absolute target>
    local src="$REPO/$1" dest="$2"
    if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
        echo "ok      $dest"
        return
    fi
    run mkdir -p "$(dirname "$dest")"
    if [[ -e "$dest" || -L "$dest" ]]; then
        echo "backup  $dest -> $dest.bak.$STAMP"
        run mv "$dest" "$dest.bak.$STAMP"
    fi
    echo "link    $dest -> $src"
    run ln -s "$src" "$dest"
}

install_local() { # install_local <repo-relative example> <target>: seed a private file once
    local example="$REPO/$1" dest="$2"
    if [[ -e "$dest" ]]; then
        echo "ok      $dest (kept)"
    else
        echo "create  $dest (from $1; fill in secrets)"
        if (( ! DRY_RUN )); then install -m 600 "$example" "$dest"; fi
    fi
}

echo "Installing from $REPO$( ((DRY_RUN)) && echo " (dry run)")"
link zsh/.zshrc              "$HOME/.zshrc"
link zsh/.zprofile           "$HOME/.zprofile"
link bash/.bashrc            "$HOME/.bashrc"
link tmux/.tmux.conf         "$HOME/.tmux.conf"
link git/.gitconfig          "$HOME/.gitconfig"
link nvim/.config/nvim       "$HOME/.config/nvim"
link herdr/.config/herdr/config.toml "$HOME/.config/herdr/config.toml"
link ghostty/.config/ghostty/config "$HOME/.config/ghostty/config"
install_local zsh/.zshrc.local.example   "$HOME/.zshrc.local"
install_local bash/.bashrc.local.example "$HOME/.bashrc.local"

echo
echo "Prerequisite check:"
need() { command -v "$1" >/dev/null && echo "  ok   $1" || echo "  MISSING  $1  ($2)"; }
need git   "required"
need zsh   "required for the zsh config"
need tmux  "required for the tmux config"
need nvim  "need >= 0.11"
need rg    "ripgrep, used by Telescope live grep"
need xclip "tmux copy-mode and nvim clipboard on X11"
need gcc   "treesitter parsers compile with a C compiler"
need node  "several language servers run on node"
[[ -d "$HOME/.oh-my-zsh" ]] || echo "  MISSING  oh-my-zsh  (https://ohmyz.sh) and its plugin zsh-autosuggestions"
if command -v nvim >/dev/null; then
    ver="$(nvim --version | head -1 | sed -E 's/.*v([0-9]+)\.([0-9]+).*/\1 \2/')"
    read -r major minor <<<"$ver"
    (( major > 0 || minor >= 11 )) || echo "  WARNING  nvim $major.$minor is too old; this config needs 0.11+"
fi
echo
echo "Next: open nvim once (plugins, parsers and language servers install on first run);"
echo "      fill in ~/.zshrc.local and ~/.bashrc.local with your secrets."
