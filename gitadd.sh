#!/bin/sh

# used for adding submodule with temp script without manually run `git submodule add` command
set -e

git config -f temp --get-regexp '^submodule\..*\.path$' |
    while read path_key local_path
    do
        url_key=$(echo $path_key | sed 's/\.path/.url/')
        url=$(git config -f temp --get "$url_key")
        git submodule add $url $local_path
    done