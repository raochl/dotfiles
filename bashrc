#! /bin/bash

if [ -f /etc/bash.bashrc ]; then 
    source /etc/bash.bashrc 
fi

export EDITOR=vim

# prompt 
source ~/.bash/prompt.bash

# shell colors
if [ -f ~/.shell/colors.sh ]; then
    source ~/.shell/colors.sh
fi

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
shopt -s histappend # append to history file
# tabs shoule be 4 chars long
if [[ $- == *i* ]] && [[ -t 1 ]]; then
    tabs 4
fi

# Local customizations allowed and encouraged!
if [ -f ~/.bashrc_local ]; then 
    source ~/.bashrc_local 
fi 
