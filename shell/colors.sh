#! /usr/bin/env sh

# Shell color configuration shared by bash and zsh.

if [ "$(uname -s)" = "Darwin" ]; then
    export CLICOLOR=1
    export LSCOLORS="${LSCOLORS:-ExGxBxDxCxEgEdxbxgxcxd}"
elif [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    # WSL DrvFs often marks Windows directories as 777, triggering GNU ls's
    # other-writable background colors. Use underlined blue instead.
    LS_COLORS="${LS_COLORS%:}:ow=04;34:tw=04;34"
    export LS_COLORS
fi
