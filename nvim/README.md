# NeoVim Setup

## Install NeoVim from source on server
How to install NeoVim from GitHub repository on server such as JSC:
```bash
cd 
git clone https://github.com/neovim/neovim
cd neovim
make clean
make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
make install
```

To add neovim to your path, add the following line to your configuration file:
```bash
echo 'export PATH="$HOME/neovim/bin:$PATH"' >> ~/.bashrc
```
If you don't use `bash`, then make sure to change out  `.bashrc` with the appropriate
configuration file.

Then, you can restart your shell with the following command:
```bash
exec $SHELL
```

## Installing extra dependencies
Some of the neovim plugins might require additional software, such as `npm`.

### Node Version Manager (NVM) and Node Package Manager (NPM)
One of the easiest ways to install `npm`, is to do it via `nvm`. This can be done as follows:

```bash
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
```

You might have to restart your shell, e.g. by using `exec $SHELL`. Then, you can install the
latest version of `npm` as follows:
```bash
nvm install --latest-npm
```

### Cargo (via rustup)
To install some apps, such as `ripgrep`, you might be better off using `cargo`, the `Rust`
package manager, which can be installed using `rustup` as follows:

```bash
curl https://sh.rustup.rs -sSf | sh
```

Then you can add `cargo` to path by running the following line (assuming you use `bash`/`zsh`):

```bash
. "$HOME/.cargo/env"
```

Note the leading dot.

### ripgrep (using Cargo)

Once you have installed `cargo`, you can easily install `ripgrep` as follows:

```bash
cargo install ripgrep
```

## Troubleshooting
In this part I will (hopefully) add any troubleshooting steps that I encounter while
doing this installation:

- You encounter the following error: `as: unrecognized option '--gdwarf-5'`
  
  In this case, I found that there was a mismatch between the `gcc` version and the `as`
  version (whatever `as` is). Solution: Install a different version of `binutils`. In my
  case, I installed the right version as follows:

  ```bash
  module load binutils/2.42-GCCcore-13.3.0
  ```
  Note that this was because I saw that I add loaded this particular version of `GCCcore`,
  so if you're using a different version then you might have to change out the version.
