#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Symlinks
ln -s "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf
ln -s "$SCRIPT_DIR/.gitconfig" ~/.gitconfig
ln -s "$SCRIPT_DIR/.aliases" ~/.aliases

mkdir -p ~/.config
ln -s "$SCRIPT_DIR/nvim" ~/.config/nvim
ln -s "$SCRIPT_DIR/kitty" ~/.config/kitty

# Setting up plugins for tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
~/.tmux/plugins/tpm/bin/install_plugins
