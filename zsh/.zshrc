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
export BAT_THEME="ansi"

alias ls="eza -1 --icons=auto --group-directories-first"
alias ll="eza -lah --icons=auto --git --group-directories-first"
alias la="eza -a --icons=auto --group-directories-first"
alias lt="eza --tree --level=2 --icons=auto --group-directories-first"
alias cat="bat"
alias vim="nvim"
alias emacs="emacs -nw"
alias gt="$HOME/dotfiles/ghostty/ghostty-theme"

# ─── Mystery Shack theme sync ─────────────────────────────────
# Terminal already serves Mystery Shack in the 16 ANSI slots, so ANSI-drawing tools
# (bat, delta, eza, syntax-highlighting) just follow it. Only tools that paint
# their own hex (fzf below, plus tmux/starship/lazygit/nvim/superfile) need the
# palette spelled out.

# fzf: bg:-1 keeps the terminal's background-opacity showing through
export FZF_DEFAULT_OPTS="\
--color=fg:#e3d3bf,bg:-1,hl:#c69261 \
--color=fg+:#e3d3bf,bg+:#2f2721,hl+:#e4af7d \
--color=info:#9b8a7d,border:#2f2721,prompt:#a7c789 \
--color=pointer:#c69261,marker:#e4a4c9,spinner:#71cec4,header:#71cec4"

# eza: ANSI codes only (EZA_COLORS has no truecolor support).
# Color is assigned by FREQUENCY, not by importance: directories are the most
# numerous colored thing in any listing, so they get the calm accent (36=turquoise).
# Amber is spent only on eza's "immediate" class -- package.json, Dockerfile,
# README, tsconfig -- which is a handful of files and genuinely means "start here".
export EZA_COLORS="di=36:ex=32:ln=35:im=4;33:sn=90:sb=90:da=90:uu=90:gu=90:ur=90:uw=90:ux=90"

# zsh-syntax-highlighting: must come after oh-my-zsh.sh or the plugin wins
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=green'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[path]='fg=blue'
ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'

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

# bun completions
[ -s "/Users/xiao8/.bun/_bun" ] && source "/Users/xiao8/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/Users/xiao8/.opencode/bin:$PATH
