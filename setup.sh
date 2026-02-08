#!/bin/bash

# Setup dotfiles symlinks

DOTFILES_DIR="$HOME/dotfiles"

# Function to create symlink
link_config() {
  local src="$1"
  local dst="$2"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "⚠️  $dst already exists (not a symlink). Skipping..."
    return
  fi

  if [ -L "$dst" ]; then
    rm "$dst"
  fi

  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "✅ Linked: $dst -> $src"
}

# Neovim
link_config "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Warp (if config exists)
if [ -d "$DOTFILES_DIR/warp" ]; then
  link_config "$DOTFILES_DIR/warp/settings.toml" "$HOME/.warp/settings.toml"
fi

# Superfile (if config exists)
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

echo "✨ Setup complete!"
