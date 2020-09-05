#! /usr/bin/env bash
# Change directory to root of current git directory, if currently in one
# gitrt [dir-on-fail]
gitrt(){
    if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]];then
        echo "$0 [dir-on-fail]"
        return 1
    fi

    dof="${1:-$(pwd)}"

    if [ -e ./.git ];then
        return 0
    fi

    if [[ "$(pwd)" == "/" ]];then
        cd "$dof"
        return 1
    fi

    cd ../

    $0 "$dof"
}


# update dotfiles 
dfu(){
    (
	cd ~/.dotfiles && git pull --ff-only && ./install -q
    )
}

# create a directory and cd into it 
mcd(){
    mkdir "${1}" && cd "${1}"
}



