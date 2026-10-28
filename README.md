# dotfiles

This is my dotfiles repository. There are many repository like it, but this one is mine.

## Setup
I'm using the [DotBot](https://github.com/anishathalye/dotbot) to manage my setup. Just clone this repository and run its `install` script from your home directory.

You will need Git installed.
Replace `YOUR_GITHUB_USER` with the account hosting your fork:
```bash
cd ~
git clone https://github.com/YOUR_GITHUB_USER/dotfiles
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
- herdr
- vim
- nvim
- tmux
- gitconfig
```

Herdr's portable configuration is tracked at `herdr/config.toml` and linked to
`~/.config/herdr/config.toml`. Session state and logs remain machine-local.
Herdr uses the host terminal palette, restores the input source after prefix
commands, and delivers toasts in Herdr. Pane borders show agent labels.

The iTerm2 `Nord` dynamic profile is linked from `iterm/Profiles.json` into
`~/Library/Application Support/iTerm2/DynamicProfiles/Profiles.json`.
Tmux uses `tmux-256color`, bottom pane title bars, prefix + Left/Right for
window switching, prefix + </> for pane swapping, and copies mouse selections
on release. Neovim wraps long lines by default.

The printable shortcut reference is available as
[`HTML`](herdr-nvim-cheatsheet.html) and [`PDF`](herdr-nvim-cheatsheet.pdf).

Git identity and repository-specific credential helpers belong in
`~/.gitconfig_local`, which the tracked Git configuration already includes.
Keep names, email addresses, private repository URLs, application IDs, and
credentials out of tracked files. Vim's generated file headers leave the author
blank rather than embedding a personal identity.

Before committing, stage explicit paths instead of `git add .`, review
`git diff --cached`, and inspect the author/committer identity. Check exported
documents for hidden metadata and local paths as well. Cleaning current files
does not remove information from existing Git history.

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
GitHub domains are not bypassed by the default `NO_PROXY` list, so GitHub HTTP
traffic uses the proxy when it is enabled. Zsh exports `~/bin` and
`~/.local/bin` for user-installed command-line tools.

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
