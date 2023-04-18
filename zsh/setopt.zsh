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

# ================== Tmux configuration =================
# CONFIGURATION VARIABLES
# Automatically start tmux
: ${ZSH_TMUX_AUTOSTART:=false}
# Only autostart once. If set to false, tmux will attempt to
# autostart every time your zsh configs are reloaded.
: ${ZSH_TMUX_AUTOSTART_ONCE:=true}
# Automatically connect to a previous session if it exists
: ${ZSH_TMUX_AUTOCONNECT:=true}
# Automatically close the terminal when tmux exits
: ${ZSH_TMUX_AUTOQUIT:=$ZSH_TMUX_AUTOSTART}
# Set term to screen or screen-256color based on current terminal support
: ${ZSH_TMUX_FIXTERM:=true}
# Set '-CC' option for iTerm2 tmux integration
: ${ZSH_TMUX_ITERM2:=false}
# The TERM to use for non-256 color terminals.
# Tmux states this should be screen, but you may need to change it on
# systems without the proper terminfo
: ${ZSH_TMUX_FIXTERM_WITHOUT_256COLOR:=screen}
# The TERM to use for 256 color terminals.
# Tmux states this should be screen-256color, but you may need to change it on
# systems without the proper terminfo
: ${ZSH_TMUX_FIXTERM_WITH_256COLOR:=screen-256color}
# Set the configuration path
: ${ZSH_TMUX_CONFIG:=$HOME/.tmux.conf}
# Set -u option to support unicode
: ${ZSH_TMUX_UNICODE:=false}

# Determine if the terminal supports 256 colors
if [[ $terminfo[colors] == 256 ]]; then
  export ZSH_TMUX_TERM=$ZSH_TMUX_FIXTERM_WITH_256COLOR
else
  export ZSH_TMUX_TERM=$ZSH_TMUX_FIXTERM_WITHOUT_256COLOR
fi

# Set the correct local config file to use.
if [[ "$ZSH_TMUX_ITERM2" == "false" && -e "$ZSH_TMUX_CONFIG" ]]; then
  export ZSH_TMUX_CONFIG
  export _ZSH_TMUX_FIXED_CONFIG="${0:h:a}/tmux.extra.conf"
else
  export _ZSH_TMUX_FIXED_CONFIG="${0:h:a}/tmux.only.conf"
fi
