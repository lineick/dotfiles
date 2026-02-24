#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

#! WARNING: uncommenting will overwrite your shortcuts.csv
# perl manage_shortcuts.pl -i shortcuts.csv

ln -s "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf
ln -s "$SCRIPT_DIR/.gitconfig" ~/.gitconfig
ln -s "$SCRIPT_DIR/.aliases" ~/.aliases

mkdir -p ~/.config
ln -s "$SCRIPT_DIR/nvim" ~/.config/nvim

# Only run these if not in SSH session
if [ -z "$SSH_CONNECTION" ]; then
    ln -s "$SCRIPT_DIR/kitty" ~/.config/kitty # terminal
    ln -s "$SCRIPT_DIR/warpd" ~/.config/warpd # agnostic mouse sim
    ln -s "$SCRIPT_DIR/hints" ~/.config/hints # vimium-like mouse sim
    ln -s "$SCRIPT_DIR/sioyek" ~/.config/sioyek # keyboard-driven PDF viewer
    # custom scripts
    mkdir -p ~/.local/bin
    ln -s "$SCRIPT_DIR/set-default-firefox" ~/.local/bin/set-default-firefox # firefox profile toggle
    ln -s "$SCRIPT_DIR/latex-screenshot/latex-screenshot" ~/.local/bin/latex-screenshot # screeenshot to latex math
    ln -s "$SCRIPT_DIR/latex-screenshot/latexocrd.py" ~/.local/bin/latexocrd.py # pix2text OCR daemon for latex-screenshot
    # Zsh plugins
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || true

    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true

    git clone https://github.com/jeffreytse/zsh-vi-mode \
      "$ZSH_CUSTOM/plugins/zsh-vi-mode" || true
    # symlink obsidian plugin configs (tell the plugins the path manually)
    #? NOTE: for latex suite the path shall not be hidden
    # ln -s "$SCRIPT_DIR/obsidian" <your-vault-path>/config


fi

# Tmux plugins always installed
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true
~/.tmux/plugins/tpm/bin/install_plugins


