#! /bin/bash

if [ -f /etc/bash.bashrc ]; then 
    source /etc/bash.bashrc 
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Color prompt with version control branch name
__vcprompt=""
if [ -f /usr/share/git/git-prompt.sh ]; then
    source /usr/share/git/git-prompt.sh
    __vcprompt="$__vcprompt"'$(__git_ps1)'
elif [ -f /etc/bash_completion.d/git-prompt ]; then
    source /etc/bash_completion.d/git-prompt
    __vcprompt="$__vcprompt"'$(__git_ps1)'
fi

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PROMPT_COLOR='\e[1;33m'
elif [ -n "$container" ]; then
    PROMPT_COLOR='\e[1;37m'
else
    PROMPT_COLOR='\e[1;32m'
fi
PS1='\['"$PROMPT_COLOR"'\][\u@\h \W\[\033[1;36m\]'"$__vcprompt"'\['"$PROMPT_COLOR"'\]]\$\[\e[0m\] '


# CNF
if [ -f /usr/share/doc/pkgfile/command-not-found.bash ]; then
    source /usr/share/doc/pkgfile/command-not-found.bash
fi


# Autojump
if [ -f /etc/profile.d/autojump.sh ]; then
    source /etc/profile.d/autojump.sh
elif [ -f /usr/share/autojump/autojump.bash ]; then
    source /usr/share/autojump/autojump.bash
fi

# Bash completion (stolen from Ubuntu's skeleton bashrc)
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Editor
if [ ! -z $(type -p nvim) ]; then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

# Calculate with C-q, from http://askubuntu.com/a/379615/96292
bind '"\C-q": "\C-aqalc \C-m"'



# alias 

if [ -f ~/.shell/aliases.sh ]; then 
    source ~/.shell/aliases.sh
fi

if [ -f ~/.shell/function.sh ]; then 
    source ~/.shell/function.sh
fi

# Ignore space commands and repeate commands from history
export HISTCONTROL=ignoreboth
export HISTFILESIZE=500000
export HISTSIZE=500000

# tabs shoule be 4 chars long
tabs 4

# Local customizations allowed and encouraged!
if [ -f ~/.bashrc_local ]; then 
    source ~/.bashrc_local 
fi 


