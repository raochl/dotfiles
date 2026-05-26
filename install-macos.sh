#!/usr/bin/env bash

set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install it from https://brew.sh/ first." >&2
  exit 1
fi

cd "$(dirname "$0")"

echo "==> Installing macOS CLI dependencies"
brew install \
  neovim \
  vim \
  tmux \
  ripgrep \
  tree-sitter \
  node \
  wget

echo "==> Configuring npm CA bundle"
if command -v npm >/dev/null 2>&1; then
  npm_cafile="$(brew --prefix ca-certificates)/share/ca-certificates/cacert.pem"
  if [[ -f "$npm_cafile" ]]; then
    npm config set cafile "$npm_cafile"
    npm config delete ca >/dev/null 2>&1 || true
  fi
fi

echo "==> Initializing dotfiles submodules"
git submodule update --init --recursive

echo "==> Linking dotfiles"
./install

echo "==> Installing tmux plugins"
TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins" "$HOME/.tmux/plugins/tpm/bin/install_plugins" || true

echo "==> Installing/restoring Neovim plugins"
nvim --headless '+Lazy! restore' '+qa'

echo "==> Installing Neovim Mason tools"
nvim --headless '+MasonToolsInstallSync' '+qa'

echo "==> Done"
echo "Open a new iTerm2 tab, or run: source ~/.zshrc"
