# ~/.zshrc

# --- PATH ---------------------------------------------------------------------
# `typeset -U` keeps PATH free of duplicates (installers append to it from several files).
typeset -U path PATH
path=(
    $HOME/.nvm/versions/node/v23.11.1/bin   # default node (nvm itself is lazy-loaded below)
    $HOME/.local/bin
    $HOME/.opencode/bin
    /opt/arm-gnu-toolchain-12.3.rel1-x86_64-arm-none-eabi/bin
    $HOME/zig-x86_64-linux-0.14.1
    $HOME/.local/share/pnpm
    $HOME/bin
    /usr/local/bin
    $path
    /usr/local/go/bin
)

# --- Oh My Zsh ----------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
zstyle ':omz:update' mode reminder
plugins=(git python docker-compose zsh-autosuggestions)

HISTSIZE=50000
SAVEHIST=50000
fpath+=~/.zfunc            # must be added before oh-my-zsh runs compinit
source $ZSH/oh-my-zsh.sh

setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS
zstyle ':completion:*' menu select

# zsh-autosuggestions: Ctrl-Space accepts, history first then completion
bindkey '^ ' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# --- Editor & aliases ---------------------------------------------------------
export EDITOR="nvim"
alias vim="nvim"
alias vi="nvim"
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias docker-compose="docker compose"
alias xdg-open="xdg-open 2>/dev/null"   # suppress xdg-open noise

# ESP toolchains (single quotes: expand $PATH when the alias runs, not when it is defined)
alias get_idf='. $HOME/esp/esp-idf/export.sh'
alias get_lx106='export PATH="$PATH:$HOME/esp/xtensa-lx106-elf/bin"'
alias cubeide="/opt/st/stm32cubeide_1.16.1/stm32cubeide"

# --- Language toolchains (lazy where it matters for startup time) -------------
# pyenv: --no-rehash skips regenerating shims on every shell start
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - --no-rehash zsh)"

# nvm: loaded on first use of the `nvm` command (sourcing it costs ~0.6s per shell)
export NVM_DIR="$HOME/.nvm"
nvm() {
    unfunction nvm
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
    nvm "$@"
}

# gvm: take the default Go from its environment file (cheap, and follows `gvm use --default`);
# the full gvm loads on first use of the `gvm` command.
[[ -f "$HOME/.gvm/environments/default" ]] && source "$HOME/.gvm/environments/default" 2>/dev/null
gvm() {
    unfunction gvm
    source "$HOME/.gvm/scripts/gvm" 2>/dev/null
    gvm "$@"
}

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
. "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null || true

# thefuck: initialised on first use (its init is slow)
if (( $+commands[thefuck] )); then
    fuck() {
        unfunction fuck
        eval "$(thefuck --alias)"
        fuck "$@"
    }
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"

# Azure CLI completion (zsh needs bashcompinit for this bash-style script)
if [[ -f "$HOME/lib/azure-cli/az.completion" ]]; then
    autoload -U +X bashcompinit && bashcompinit
    source "$HOME/lib/azure-cli/az.completion"
fi

# --- Optional tools (only if installed) ---------------------------------------
(( $+commands[fzf] ))    && source <(fzf --zsh)               # Ctrl-R / Ctrl-T / Alt-C
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"         # `z <dir>` smart cd

# --- Machine-specific settings and secrets (not tracked in git) ---------------
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
