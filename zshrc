#! /usr/bin/env zsh


# Zsh configuration 

[[ -f ~/.zshrc_local_pre ]] && source ~/.zshrc_local_pre 


source ~/.zsh/setopt.zsh
source ~/.zsh/export.zsh
source ~/.zsh/bindings.zsh
source ~/.zsh/prompt.zsh 
source ~/.zsh/completion.zsh
source ~/.zsh/plugins.zsh

source ~/.shell/aliases.sh
source ~/.shell/function.sh

# ------
[[ -f ~/.bashrc_local ]] && source ~/.bashrc_local 
[[ -f ~/localDot/zshrc_local_before ]] && source ~/localDot/zshrc_local_before 
[[ -f ~/localDot/aliases_local.sh ]] && source ~/localDot/aliases_local.sh

