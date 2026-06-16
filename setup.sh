#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

#! WARNING: uncommenting will overwrite your shortcuts.csv
# perl manage_shortcuts.pl -i shortcuts.csv

ln -sfn "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf
ln -sfn "$SCRIPT_DIR/.gitconfig" ~/.gitconfig
ln -sfn "$SCRIPT_DIR/.aliases" ~/.aliases

mkdir -p ~/.config
ln -sfn "$SCRIPT_DIR/nvim" ~/.config/nvim

# Only run these if not in SSH session
if [ -z "$SSH_CONNECTION" ]; then
    mkdir -p ~/.claude
    ln -sfn "$SCRIPT_DIR/.claude/settings.json" ~/.claude/settings.json
    ln -sfn "$SCRIPT_DIR/.claude/CLAUDE.md"     ~/.claude/CLAUDE.md
    ln -sfn "$SCRIPT_DIR/.claude/agents"        ~/.claude/agents
    ln -sfn "$SCRIPT_DIR/.claude/commands"      ~/.claude/commands
    ln -sfn "$SCRIPT_DIR/.claude/hooks"         ~/.claude/hooks

    ln -sfn "$SCRIPT_DIR/onedriver" ~/.config/onedriver # connect onedrive as remote file system
    ln -sfn "$SCRIPT_DIR/kitty" ~/.config/kitty # terminal
    ln -sfn "$SCRIPT_DIR/warpd" ~/.config/warpd # agnostic mouse sim
    ln -sfn "$SCRIPT_DIR/hints" ~/.config/hints # vimium-like mouse sim
    ln -sfn "$SCRIPT_DIR/sioyek" ~/.config/sioyek # keyboard-driven PDF viewer
    mkdir -p ~/.config/lektra
    ln -sfn "$SCRIPT_DIR/lektra/config.toml" ~/.config/lektra/config.toml # keyboard-driven PDF viewer (currently preferred over sioyek)
    # custom scripts
    mkdir -p ~/.local/bin
    ln -sfn "$SCRIPT_DIR/set-default-firefox" ~/.local/bin/set-default-firefox # firefox profile toggle
    ln -sfn "$SCRIPT_DIR/latex-screenshot/latex-screenshot" ~/.local/bin/latex-screenshot # screeenshot to latex math
    ln -sfn "$SCRIPT_DIR/latex-screenshot/latexocrd.py" ~/.local/bin/latexocrd.py # pix2text OCR daemon for latex-screenshot
    # idle-suspend toggle for gpu jobs (optional, only for nvidia laptops)
    # ln -s "$SCRIPT_DIR/nosleep/nosleep" ~/.local/bin/nosleep
    # systemctl --user enable --now "$SCRIPT_DIR/nosleep/nosleep.service" || true
    # Zsh plugins
    ln -sfn "$SCRIPT_DIR/.zshrc" ~/.zshrc
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
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


