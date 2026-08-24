#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
ok() { echo -e "${GREEN}[OK]${NC} $1"; }
skip() { echo -e "${YELLOW}[SKIP]${NC} $1"; }

# ─── 1. Homebrew ───────────────────────────────────────────────

info "Checking Homebrew..."
if command -v brew &>/dev/null; then
  ok "Homebrew already installed"
else
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ok "Homebrew installed"
fi

if ! command -v brew &>/dev/null; then
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# ─── 2. Brew bundle ───────────────────────────────────────────

info "Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"
ok "Brew bundle complete"

# ─── 3. Oh My Zsh ─────────────────────────────────────────────

info "Checking Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  ok "Oh My Zsh already installed"
else
  info "Installing Oh My Zsh..."
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  ok "Oh My Zsh installed"
fi

# ─── 4. Zsh plugins ───────────────────────────────────────────

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

info "Checking zsh-autosuggestions..."
if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  ok "zsh-autosuggestions already installed"
else
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  ok "zsh-autosuggestions installed"
fi

info "Checking zsh-syntax-highlighting..."
if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  ok "zsh-syntax-highlighting already installed"
else
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  ok "zsh-syntax-highlighting installed"
fi

# ─── 5. Symlinks ──────────────────────────────────────────────

info "Creating symlinks..."

link_config() {
  local src="$1"
  local dst="$2"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    local backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$backup"
    ok "Backed up existing config: $backup"
  fi

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    ok "Already linked: $dst -> $src"
    return
  fi

  if [ -L "$dst" ]; then
    rm "$dst"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  ok "Linked: $dst -> $src"
}

# Neovim
link_config "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Emacs (Doom): user config lives in dotfiles, framework cloned separately.
#   ~/.config/doom  -> dotfiles/emacs   (this repo, versioned)
#   ~/.config/emacs -> doomemacs clone  (NOT versioned, heavy)
if [ -d "$DOTFILES_DIR/emacs" ]; then
  DOOM_DIR="$HOME/.config/emacs"

  if [ -d "$DOOM_DIR/.git" ] || [ -L "$DOOM_DIR" ]; then
    ok "Doom Emacs already present"
  else
    if [ -e "$DOOM_DIR" ] && [ ! -L "$DOOM_DIR" ]; then
      backup="$DOOM_DIR.backup.$(date +%Y%m%d%H%M%S)"
      mv "$DOOM_DIR" "$backup"
      ok "Backed up existing emacs dir: $backup"
    fi
    info "Cloning Doom Emacs into ~/.config/emacs ..."
    git clone --depth 1 https://github.com/doomemacs/doomemacs "$DOOM_DIR"
    ok "Doom Emacs cloned"
  fi

  # symlink user config: ~/.config/doom -> dotfiles/emacs
  link_config "$DOTFILES_DIR/emacs" "$HOME/.config/doom"

  if [ -x "$DOOM_DIR/bin/doom" ]; then
    if [ ! -d "$DOOM_DIR/.local/straight" ]; then
      info "Running 'doom install' (first time, downloads packages) ..."
      "$DOOM_DIR/bin/doom" -y install
      ok "Doom install complete"
    else
      info "Running 'doom sync' ..."
      "$DOOM_DIR/bin/doom" sync
      ok "Doom sync complete"
    fi
  fi
fi

# Warp
if [ -d "$DOTFILES_DIR/warp" ]; then
  link_config "$DOTFILES_DIR/warp/settings.toml" "$HOME/.warp/settings.toml"
fi

# Superfile
if [ -d "$DOTFILES_DIR/superfile" ]; then
  link_config "$DOTFILES_DIR/superfile/config.toml" "$HOME/.config/superfile/config.toml"
  if [ -d "$DOTFILES_DIR/superfile/theme" ]; then
    link_config "$DOTFILES_DIR/superfile/theme" "$HOME/.config/superfile/theme"
  fi
fi

# Zsh
if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
  link_config "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
fi

# Starship
if [ -f "$DOTFILES_DIR/starship/starship.toml" ]; then
  link_config "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
fi

# Lazygit
if [ -f "$DOTFILES_DIR/lazygit/config.yml" ]; then
  link_config "$DOTFILES_DIR/lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
fi

# AeroSpace
if [ -f "$DOTFILES_DIR/aerospace/.aerospace.toml" ]; then
  link_config "$DOTFILES_DIR/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"
fi

# Ghostty
if [ -f "$DOTFILES_DIR/ghostty/config" ]; then
  link_config "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
fi

# tmux
if [ -f "$DOTFILES_DIR/tmux/.tmux.conf" ]; then
  link_config "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
fi

# ─── 6. Git delta ─────────────────────────────────────────────

info "Checking git-delta config..."
if [ "$(git config --global core.pager)" = "delta" ]; then
  ok "git-delta already configured"
else
  info "Configuring git-delta..."
  git config --global core.pager "delta"
  git config --global interactive.diffFilter "delta --color-only"
  git config --global delta.navigate true
  git config --global delta.side-by-side true
  git config --global delta.line-numbers true
  git config --global merge.conflictStyle "zdiff3"
  ok "git-delta configured"
fi

# Mystery Shack colors for delta. syntax-theme follows $BAT_THEME ("ansi"),
# which makes delta render with the terminal's own 16 ANSI colors.
info "Applying Mystery Shack colors to delta..."
git config --global delta.syntax-theme "ansi"
git config --global delta.plus-style "syntax #26301f"
git config --global delta.minus-style "syntax #3a2620"
git config --global delta.plus-emph-style "syntax #354628"
git config --global delta.minus-emph-style "syntax #55352c"
git config --global delta.line-numbers-plus-style "#a7c789"
git config --global delta.line-numbers-minus-style "#eea695"
git config --global delta.line-numbers-zero-style "#9b8a7d"
git config --global delta.file-style "#c69261 bold"
git config --global delta.file-decoration-style "#2f2721 ul"
git config --global delta.hunk-header-style "syntax"
git config --global delta.hunk-header-decoration-style "#9b8a7d box"
ok "delta colors applied"

# ─── 7. macOS app startup ─────────────────────────────────────

if [ -d "/Applications/AeroSpace.app" ]; then
  info "Starting AeroSpace..."
  open -a AeroSpace || true

  if aerospace --version 2>/dev/null | grep -q "server version: Unknown"; then
    skip "AeroSpace needs Accessibility permission: Privacy & Security -> Accessibility -> AeroSpace"
    open "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility" || true
  else
    ok "AeroSpace is running"
  fi
fi

echo ""
echo -e "${GREEN}Setup complete!${NC}"
echo -e "${BLUE}[INFO]${NC} Restart your terminal or run: exec zsh"
