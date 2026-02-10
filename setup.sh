#!/bin/bash

set -e

DOTFILES_DIR="$HOME/dotfiles"

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
    skip "$dst already exists (not a symlink)"
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

# Warp
if [ -d "$DOTFILES_DIR/warp" ]; then
  link_config "$DOTFILES_DIR/warp/settings.toml" "$HOME/.warp/settings.toml"
fi

# Superfile
if [ -d "$DOTFILES_DIR/superfile" ]; then
  link_config "$DOTFILES_DIR/superfile/config.toml" "$HOME/.config/superfile/config.toml"
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

echo ""
echo -e "${GREEN}Setup complete!${NC}"
