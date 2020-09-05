#! /usr/bin/env zsh


# =================== History =======================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history 

# Allow multiple terminal sessions to all append to one zsh command history 
setopt APPEND_HISTORY

# Add commands as they are typed, dont wait until shell exit
setopt inc_append_history

# Dont write events to the history that are duplicates of previous events 
setopt hist_ignore_dups

# Include more information about when the command was executed, etc
setopt extended_history 

# Remove extra blanks from each command line being added to history
setopt hist_reduce_blanks


# =================== Completion ====================

# Allow completion from within a word/phrase 
setopt complete_in_word 

# When completing from the middle of a word, move the cursor to the end of the word 
setopt always_to_end 

# Automatically use menu completion after the second consecutive request from completion 
setopt auto_menu 

# unset menu complete instead of insert match immediately , list possibilities first 
unsetopt menu_complete 

# ================== Prompt =========================

# Enable param and arithmetic expansion, and command substitution 
setopt prompt_subst 

