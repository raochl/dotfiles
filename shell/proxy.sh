#! /usr/bin/env bash

# Unified proxy and package-manager network settings.
# Override values in ~/.config/dotfiles/proxy.local.sh or ~/.proxyrc.

if [ -f "$HOME/.config/dotfiles/proxy.local.sh" ]; then
    # shellcheck disable=SC1091
    . "$HOME/.config/dotfiles/proxy.local.sh"
fi

if [ -f "$HOME/.proxyrc" ]; then
    # shellcheck disable=SC1090
    . "$HOME/.proxyrc"
fi

: "${DOTFILES_PROXY_ENABLED:=1}"
: "${DOTFILES_PROXY_HOST:=127.0.0.1}"
: "${DOTFILES_PROXY_PORT:=7897}"
: "${DOTFILES_PROXY_HTTP_SCHEME:=http}"
: "${DOTFILES_PROXY_ALL_SCHEME:=socks5h}"
: "${DOTFILES_NO_PROXY:=localhost,127.0.0.1,::1,github.com,api.github.com,raw.githubusercontent.com,ghcr.io,mirrors.aliyun.com,mirrors.tuna.tsinghua.edu.cn,mirrors.ustc.edu.cn}"

: "${DOTFILES_NPM_REGISTRY:=https://registry.npmmirror.com}"
: "${DOTFILES_NPM_STRICT_SSL:=true}"
: "${DOTFILES_NODE_CA_FILE:=}"
: "${DOTFILES_NPM_CAFILE:=}"

: "${DOTFILES_HOMEBREW_API_DOMAIN:=https://mirrors.aliyun.com/homebrew/homebrew-bottles/api}"
: "${DOTFILES_HOMEBREW_BOTTLE_DOMAIN:=https://mirrors.aliyun.com/homebrew/homebrew-bottles}"
: "${DOTFILES_HOMEBREW_PIP_INDEX_URL:=http://mirrors.aliyun.com/pypi/simple}"

DOTFILES_PROXY_HTTP_URL="${DOTFILES_PROXY_HTTP_SCHEME}://${DOTFILES_PROXY_HOST}:${DOTFILES_PROXY_PORT}"
DOTFILES_PROXY_ALL_URL="${DOTFILES_PROXY_ALL_SCHEME}://${DOTFILES_PROXY_HOST}:${DOTFILES_PROXY_PORT}"
export DOTFILES_PROXY_ENABLED DOTFILES_PROXY_HOST DOTFILES_PROXY_PORT
export DOTFILES_PROXY_HTTP_URL DOTFILES_PROXY_ALL_URL DOTFILES_NO_PROXY
export DOTFILES_NPM_REGISTRY DOTFILES_NPM_STRICT_SSL DOTFILES_NODE_CA_FILE DOTFILES_NPM_CAFILE

_dotfiles_homebrew_ca_file() {
    if command -v brew >/dev/null 2>&1; then
        local ca_prefix
        ca_prefix="$(brew --prefix ca-certificates 2>/dev/null)" || return 1
        local ca_file="${ca_prefix}/share/ca-certificates/cacert.pem"
        [ -f "$ca_file" ] && printf '%s\n' "$ca_file"
    fi
}

_dotfiles_proxy_export_env() {
    export HTTP_PROXY="$DOTFILES_PROXY_HTTP_URL"
    export HTTPS_PROXY="$DOTFILES_PROXY_HTTP_URL"
    export http_proxy="$DOTFILES_PROXY_HTTP_URL"
    export https_proxy="$DOTFILES_PROXY_HTTP_URL"
    export ALL_PROXY="$DOTFILES_PROXY_ALL_URL"
    export all_proxy="$DOTFILES_PROXY_ALL_URL"
    export NO_PROXY="$DOTFILES_NO_PROXY"
    export no_proxy="$DOTFILES_NO_PROXY"
}

_dotfiles_proxy_unset_env() {
    unset HTTP_PROXY HTTPS_PROXY http_proxy https_proxy
    unset ALL_PROXY all_proxy NO_PROXY no_proxy
}

_dotfiles_homebrew_export_env() {
    export HOMEBREW_API_DOMAIN="$DOTFILES_HOMEBREW_API_DOMAIN"
    export HOMEBREW_BOTTLE_DOMAIN="$DOTFILES_HOMEBREW_BOTTLE_DOMAIN"
    export HOMEBREW_PIP_INDEX_URL="$DOTFILES_HOMEBREW_PIP_INDEX_URL"
}

_dotfiles_node_ca_export_env() {
    if [ -f "$DOTFILES_NODE_CA_FILE" ]; then
        export NODE_EXTRA_CA_CERTS="$DOTFILES_NODE_CA_FILE"
    fi
}

proxy_on() {
    export DOTFILES_PROXY_ENABLED=1
    _dotfiles_proxy_export_env
    _dotfiles_homebrew_export_env
    _dotfiles_node_ca_export_env
}

proxy_off() {
    export DOTFILES_PROXY_ENABLED=0
    _dotfiles_proxy_unset_env
}

proxy_sync() {
    if command -v npm >/dev/null 2>&1; then
        npm config set registry "$DOTFILES_NPM_REGISTRY"
        npm config set proxy "$DOTFILES_PROXY_HTTP_URL"
        npm config set https-proxy "$DOTFILES_PROXY_HTTP_URL"
        npm config set strict-ssl "$DOTFILES_NPM_STRICT_SSL"
        local npm_cafile="${DOTFILES_NPM_CAFILE:-$(_dotfiles_homebrew_ca_file)}"
        if [ -n "$npm_cafile" ] && [ -f "$npm_cafile" ]; then
            npm config set cafile "$npm_cafile"
            npm config delete ca >/dev/null 2>&1 || true
        elif [ -n "${NODE_EXTRA_CA_CERTS:-}" ] && [ -f "$NODE_EXTRA_CA_CERTS" ]; then
            npm config set cafile "$NODE_EXTRA_CA_CERTS"
            npm config delete ca >/dev/null 2>&1 || true
        else
            npm config delete cafile >/dev/null 2>&1 || true
            npm config delete ca >/dev/null 2>&1 || true
        fi
    fi
}

proxy_status() {
    echo "proxy enabled: ${DOTFILES_PROXY_ENABLED}"
    echo "proxy http:    ${DOTFILES_PROXY_HTTP_URL}"
    echo "proxy all:     ${DOTFILES_PROXY_ALL_URL}"
    echo "no proxy:      ${DOTFILES_NO_PROXY}"
    echo "node ca:       ${NODE_EXTRA_CA_CERTS:-not set}"
    echo "npm cafile:    ${DOTFILES_NPM_CAFILE:-$(_dotfiles_homebrew_ca_file)}"
    echo "npm registry:  ${DOTFILES_NPM_REGISTRY}"
    echo "brew api:      ${DOTFILES_HOMEBREW_API_DOMAIN}"
    echo "brew bottles:  ${DOTFILES_HOMEBREW_BOTTLE_DOMAIN}"
}

proxy_doctor() {
    proxy_status
    echo
    command -v curl >/dev/null 2>&1 && curl -I https://ghcr.io/v2/
    command -v npm >/dev/null 2>&1 && npm ping --registry "$DOTFILES_NPM_REGISTRY"
}

proxy_ssh_snippet() {
    cat <<EOF
Host github.com
    HostName github.com
    User git
    Port 443
    ProxyCommand nc -X 5 -x ${DOTFILES_PROXY_HOST}:${DOTFILES_PROXY_PORT} %h %p
EOF
}

if [ "$DOTFILES_PROXY_ENABLED" = "1" ]; then
    proxy_on
else
    proxy_off
    _dotfiles_homebrew_export_env
fi

alias proxy-on='proxy_on'
alias proxy-off='proxy_off'
alias proxy-sync='proxy_sync'
alias proxy-status='proxy_status'
alias proxy-doctor='proxy_doctor'
alias proxy-ssh-snippet='proxy_ssh_snippet'
