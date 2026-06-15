export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

export EDITOR="nvim"
export VISUAL="nvim"
export BAT_THEME="GitHub"

alias ls="eza -1 --icons=auto --group-directories-first"
alias ll="eza -lah --icons=auto --git --group-directories-first"
alias la="eza -a --icons=auto --group-directories-first"
alias lt="eza --tree --level=2 --icons=auto --group-directories-first"
alias cat="bat"
alias vim="nvim"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if [[ -o interactive && -t 0 ]] && command -v fzf >/dev/null 2>&1; then
  FZF_BASE="$(brew --prefix fzf 2>/dev/null)"
  [ -f "$FZF_BASE/shell/key-bindings.zsh" ] && source "$FZF_BASE/shell/key-bindings.zsh"
  [ -f "$FZF_BASE/shell/completion.zsh" ] && source "$FZF_BASE/shell/completion.zsh"
  unset FZF_BASE
fi

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
