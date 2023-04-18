# aliases assignment 

# Miscellaneous bindings 
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias -- -='cd -'

# better clear
alias cl='clear'

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# GNU ls would say --color=auto 
alias ll='ls -lh'
alias la='ls -la'
alias cpr='cp -r'
alias dfh='df -h'
alias kill9='kill -9'
alias cp='cp -i'
alias mv='mv -i'


# alias clip='xsel --clipboard'
alias ipy=ipython
alias ipy3=ipython3
alias python=python3

# tmux alias
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# environment refresh
alias szrc='source ~/.zshrc'
alias sbrc='source ~/.bashrc'
