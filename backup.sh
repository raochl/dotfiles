#! /usr/bin/env bash 

mkdir backup_dot
# backup system file that is already exist
# backup bashrc
if [ -f ~/.bashrc ]; then 
    mv ~/.bashrc backup_dot/bashrc_bck
fi

# backup vimrc
if [ -f ~/.vimrc ]; then 
    mv ~/.vimrc backup_dot/vimrc 
fi

# backup zshrc 
if [ -f ~/.zshrc ]; then
    mv ~/.zshrc backup_dot/zshrc 
fi

# backup tmux 
if [ -f ~/.tmux.conf ]; then 
    mv ~/.tmux.conf backup_dot/tmux.conf 
fi

# backup bash dir 
if [ -d ~/.bash ]; then 
    rm -rf .bash 
fi

# backup zsh dir 
if [ -d ~/.zsh ]; then 
    rm -rf .zsh 
fi

# backup vim dir 
if [ -d ~/.vim ]; then 
    mv ~/.vim backup_dot/vim
fi

