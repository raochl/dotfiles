# dotfiles

This is my dotfiles repository. There are many repository like it, but this one is mine.

## Setup
I'm using the [DotBot](https://github.com/anishathalye/dotbot) to manage my setup. Just clone this repository and run its `install` script from your home directory.

You will need Git installed.
You can copy and paste:
```bash
cd ~
git clone https://github.com/raochl/dotfiles
dotfiles/install
```

For a fresh macOS machine, use:
```bash
cd ~/dotfiles
./install-macos.sh
```

If npm, Homebrew, GitHub, or Mason has network trouble, see
[`docs/new-machine-setup.md`](docs/new-machine-setup.md).

## Configuration
```yaml
- bash
- zsh
- vim
- nvim
- tmux
- gitconfig
```

## Proxy
The proxy helper lives at `~/.shell/proxy.sh` and is loaded automatically by zsh.
Use these helpers when you need to toggle or inspect proxy settings:

```bash
proxy-status
proxy-on
proxy-off
```

Defaults:
```bash
DOTFILES_PROXY_HOST=127.0.0.1
DOTFILES_PROXY_PORT=7897
DOTFILES_NPM_REGISTRY=https://registry.npmmirror.com
DOTFILES_NPM_CAFILE=$(brew --prefix ca-certificates)/share/ca-certificates/cacert.pem
```

Use `~/.config/dotfiles/proxy.local.sh` or `~/.proxyrc` for local overrides.
After sourcing it, run `proxy-status` to inspect the active settings.

## Note
About the configuration:

* vim 
    - use Vim 8+ packages to manager the plugin.
* nvim
    - use Lua config and lazy.nvim; kept separate from vimrc.
* tmux
    - not yet fix plugin.
* gitadd.sh
    - used to add submodule with temp file.
* zsh
    - copy from [anishathalye](https://github.com/anishathalye/dotfiles) and modify a little bit.
* gitconfig
    - not yet learn. Also copy from [anishathalye](https://github.com/anishathalye/dotfiles).
