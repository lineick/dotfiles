#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Symlinks
ln -s "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf
ln -s "$SCRIPT_DIR/.gitconfig" ~/.gitconfig
ln -s "$SCRIPT_DIR/.aliases" ~/.aliases
# ln -s "$SCRIPT_DIR/.obsidian.vimrc" ~/.Documents/UnderstandEverything/.obsidian.vimrc

# ln -s "$SCRIPT_DIR/.zshrc" ~/.zshrc

mkdir -p ~/.config
ln -s "$SCRIPT_DIR/nvim" ~/.config/nvim
ln -s "$SCRIPT_DIR/kitty" ~/.config/kitty
ln -s "$SCRIPT_DIR/warpd" ~/.config/warpd
ln -s "$SCRIPT_DIR/hints" ~/.config/hints

# custom scripts
mkdir -p ~/.local/bin
ln -s "$SCRIPT_DIR/set-default-firefox" ~/.local/bin/set-default-firefox

# Setting up plugins for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
~/.tmux/plugins/tpm/bin/install_plugins

git clone https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

git clone https://github.com/jeffreytse/zsh-vi-mode \
  "$ZSH_CUSTOM/plugins/zsh-vi-mode"

