# dotfiles
Contains my dotfiles, including kitty, nvim, tmux etc. Always WIP.

The structure and the `nvim` config is based on this [dotfiles](https://github.com/jarlsondre/dotfiles) repository.

## Install ipynb support with nvim via jupyter_ascending

Warning, i had some OOM errors when loading big files in jupyter, crashing its kernel and for now decided to not use this extension.
```bash
pip install jupyter_ascending editdistance==0.8.1 && \
python -m jupyter nbextension    install jupyter_ascending --sys-prefix --py && \
python -m jupyter nbextension     enable jupyter_ascending --sys-prefix --py && \
python -m jupyter serverextension enable jupyter_ascending --sys-prefix --py
```
