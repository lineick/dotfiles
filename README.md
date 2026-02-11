# dotfiles

Contains my dotfiles, including kitty, nvim, tmux etc. Always WIP.

Assumes X11.

## NEVER EVER USE A MOUSE

This whole config makes you mouse-free.
- Warp for global content-agnostic selection
- vimium-c for blazingly fast browser nav
- kitty+tmux for mouseless terminal nav and editing.
    - `<tmux-leader> [` for vim-like buffer selection (checkout [.tmux.conf](.tmux.conf), it is fully vimified)
    - `<S><C><Space>` for actually opening the kitty content in a custom vim instance (checkout [kitty+lua.lua](nvim/lua/kitty+page.lua))
        - contains custom stuff like `yy` to copy the command without the other shell symbols (regex assumes my zsh layout, you can edit the regex in [kitty+lua.lua](nvim/lua/kitty+page.lua))

- ([hints](https://github.com/AlfredoSequeida/hints) is the content-gnostic version of `warpd`, however I do not use it as it is slow with an unbearable 1-2 seconds delay)

## More Custom QOL
- With `<C>Print` I can select an area on my screen (i.e. a math formula) with left drag (use warpd for mouseless) after release the content will start a custom [LatexOCR](https://github.com/lukas-blecher/LaTeX-OCR/tree/main) daemon that copies the selected formula as latex math to the clipboard. Will build a better solution than LatexOCR at some point, just works for math formula currently. Often makes errors, but still very useful.

- To export your gnome shortcuts just run `perl manage_shortcuts.pl -e shortcuts.csv` (exports the shortcuts to a csv)
- Then you can import them on new setups with `perl manage_shortcuts.pl -i shortcuts.csv`

## Setup
Comment out what you do not want in the `setup.sh`, then
install via `setup.sh` (you will probably have to install some missing dependencies)
Other installs are in the READMEs or setup scripts in their folders.

## Acknowledgements
The structure and the `nvim` config is based on this [dotfiles](https://github.com/jarlsondre/dotfiles) repository.
