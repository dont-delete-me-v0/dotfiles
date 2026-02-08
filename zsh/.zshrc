# ---------------------
# Oh My Zsh
# ---------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # disabled — using starship

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ---------------------
# Environment
# ---------------------
export EDITOR="nvim"
export LANG="en_US.UTF-8"
export PATH="$HOME/.local/bin:$PATH"

# ---------------------
# Aliases
# ---------------------

# eza (ls replacement)
alias ls="eza --icons -1"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias lt="eza --tree --icons --level=2"

# bat (cat replacement)
alias cat="bat --paging=never"

# navigation
alias ..="cd .."
alias ...="cd ../.."

# git shortcuts
alias g="git"
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate -20"
alias gd="git diff"
alias ga="git add"
alias lg="lazygit"
alias ld="lazydocker"

# quick edit
alias vim="nvim"
alias v="nvim"
alias zshrc="nvim ~/dotfiles/zsh/.zshrc"

# ---------------------
# Tool integrations
# ---------------------

# starship prompt
eval "$(starship init zsh)"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)

# fzf + fd for file search
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# ---------------------
# Git config (delta)
# ---------------------
# delta is configured via ~/.gitconfig, not here.
# Run once if not configured:
#   git config --global core.pager delta
#   git config --global interactive.diffFilter "delta --color-only"
#   git config --global delta.navigate true
#   git config --global delta.side-by-side true
#   git config --global merge.conflictStyle zdiff3
