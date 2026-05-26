# New Machine Setup Notes

These notes capture the network and package-manager issues that can appear when
bootstrapping these dotfiles on a fresh macOS machine.

## What Can Reappear

The dotfiles symlinks and submodules are deterministic, but external installers
depend on local network policy. These areas can fail on a new machine:

- Homebrew downloads may need a mirror or a working proxy.
- GitHub SSH does not read `HTTP_PROXY` or `HTTPS_PROXY`; it needs SSH config.
- npm uses its own persistent config in `~/.npmrc`.
- Mason uses several tools under the hood: `npm`, `curl`, `wget`, and GitHub or
  ghcr.io release downloads.
- Node/npm certificate trust is separate from macOS Keychain and can fail if
  npm points at a missing CA bundle.

## Stable Defaults

The macOS bootstrap script installs `wget` and configures npm to use the
Homebrew CA bundle:

```bash
$(brew --prefix ca-certificates)/share/ca-certificates/cacert.pem
```

Do not use this path for npm:

```bash
/opt/homebrew/etc/ca-certificates/cert.pem
```

It may not exist on a fresh machine.

## npm Checklist

Check npm config:

```bash
npm config get registry
npm config get proxy
npm config get https-proxy
npm config get cafile
npm config get ca
npm config get strict-ssl
```

Recommended CA setting:

```bash
npm config set cafile "$(brew --prefix ca-certificates)/share/ca-certificates/cacert.pem"
npm config delete ca
```

Use a registry mirror only if needed:

```bash
npm config set registry https://registry.npmmirror.com
```

Use a proxy only if direct registry access fails:

```bash
npm config set proxy http://127.0.0.1:7897
npm config set https-proxy http://127.0.0.1:7897
```

Verify:

```bash
npm ping
npm view pyright version
```

## Proxy Helper

`~/.shell/proxy.sh` is loaded automatically by zsh.
Use the helper commands when the current network needs proxy changes:

```bash
proxy-status
```

For GitHub SSH, print a matching SSH config block:

```bash
proxy-ssh-snippet
```

OpenSSH still requires the generated block to be present in `~/.ssh/config`.

## Mason Checklist

After `./install-macos.sh`, verify Mason tools:

```bash
nvim --headless '+MasonToolsInstallSync' '+qa'
find ~/.local/share/nvim/mason/packages -mindepth 1 -maxdepth 1 -type d -print | sed 's#^.*/##' | sort
```

Expected core tools:

```text
bash-language-server
html-lsp
json-lsp
lua-language-server
pyright
yaml-language-server
```

## Error Map

`UNABLE_TO_GET_ISSUER_CERT_LOCALLY`
: npm cannot build a trusted certificate chain. Check `npm config get cafile`
  and ensure that file exists.

`ENOTFOUND registry.npmjs.org`
: DNS or network path failed. Try a registry mirror or npm proxy settings.

`Could not resolve host: ghcr.io`
: `curl` or `wget` cannot resolve GitHub Container Registry. Use a shell proxy
  environment such as `ALL_PROXY=socks5h://127.0.0.1:7897`.

`Could not find executable "wget"`
: Install it with `brew install wget`. The bootstrap script now includes it.

`Operation not permitted` while running Neovim from Codex
: This can be sandbox-related. Re-run the command in a normal iTerm session.

## Homebrew Cleanup

If `brew doctor` reports broken symlinks, run:

```bash
brew cleanup
```

Then re-check:

```bash
brew doctor
```
