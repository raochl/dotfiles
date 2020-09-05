#! /usr/bin/env zsh


# Zsh configuration 

[[ -f ~/.zshrc_local_pre ]] && source ~/.zshrc_local_pre 


source ~/.zsh/setopt.zsh
source ~/.zsh/export.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/prompt.zsh 
source ~/.zsh/completion.zsh
source ~/.zsh/plugins.zsh

for i in ~/.shell/*; do;
    test -r "$i" && source "$i"
done

# ------
[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local 
