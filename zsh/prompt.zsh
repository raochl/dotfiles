# User customizable options
# PR_ARROW_CHAR="[some character]"
# RPR_SHOW_USER=(true, false) - show username in rhs prompt
# RPR_SHOW_HOST=(true, false) - show host in rhs prompt
# RPR_SHOW_GIT=(true, false) - show git status in rhs prompt
# PR_EXTRA="[stuff]" - extra content to add to prompt
# RPR_EXTRA="[stuff]" - extra content to add to rhs prompt

# Set custom prompt

# Allow for variable/function substitution in prompt
setopt prompt_subst

# Load color variables to make it easier to color things
autoload -U colors && colors

# Color palette. Prefer truecolor when the terminal is known to support it,
# but keep a 256-color fallback for SSH and older terminals.
typeset -gA PR_FG

function _pr_rgb() {
    printf '\033[38;2;%s;%s;%sm' "$1" "$2" "$3"
}

function _pr_256() {
    printf '\033[38;5;%sm' "$1"
}

function _pr_supports_truecolor() {
    [[ "${COLORTERM}" == "truecolor" || "${COLORTERM}" == "24bit" ]] && return 0
    [[ -n "${WT_SESSION}" || -n "${KITTY_WINDOW_ID}" || -n "${VTE_VERSION}" ]] && return 0
    [[ "${TERM}" == *"truecolor"* || "${TERM}" == *"direct"* ]] && return 0
    if [[ -n "${TMUX}" ]] && command -v tmux >/dev/null 2>&1; then
        tmux display-message -p '#{client_termfeatures}' 2>/dev/null | grep -q RGB && return 0
    fi
    return 1
}

if _pr_supports_truecolor; then
    PR_FG[red]="$(_pr_rgb 191 97 106)"
    PR_FG[green]="$(_pr_rgb 163 190 140)"
    PR_FG[yellow]="$(_pr_rgb 235 203 139)"
    PR_FG[blue]="$(_pr_rgb 129 161 193)"
    PR_FG[magenta]="$(_pr_rgb 180 142 173)"
    PR_FG[cyan]="$(_pr_rgb 136 192 208)"
    PR_FG[teal]="$(_pr_rgb 143 188 187)"
    PR_FG[orange]="$(_pr_rgb 208 135 112)"
    PR_FG[violet]="$(_pr_rgb 180 142 173)"
    PR_FG[neon]="$(_pr_rgb 163 190 140)"
    PR_FG[pink]="$(_pr_rgb 180 142 173)"
    PR_FG[gray]="$(_pr_rgb 216 222 233)"
    PR_FG[dim]="$(_pr_rgb 97 112 134)"
else
    [[ -f ~/.zsh/spectrum.zsh ]] && source ~/.zsh/spectrum.zsh
    PR_FG[red]="$(_pr_256 131)"
    PR_FG[green]="$(_pr_256 150)"
    PR_FG[yellow]="$(_pr_256 180)"
    PR_FG[blue]="$(_pr_256 110)"
    PR_FG[magenta]="$(_pr_256 139)"
    PR_FG[cyan]="$(_pr_256 116)"
    PR_FG[teal]="$(_pr_256 109)"
    PR_FG[orange]="$(_pr_256 180)"
    PR_FG[violet]="$(_pr_256 139)"
    PR_FG[neon]="$(_pr_256 150)"
    PR_FG[pink]="$(_pr_256 139)"
    PR_FG[gray]="$(_pr_256 249)"
    PR_FG[dim]="$(_pr_256 240)"
fi

function pr_color() {
    echo "%{${PR_FG[$1]}%}"
}

PR_RESET=$'%{\e[00m%}'

# Current directory, truncated to 3 path elements (or 4 when one of them is "~")
# The number of elements to keep can be specified as ${1}
function PR_DIR() {
    local sub=${1}
    if [[ "${sub}" == "" ]]; then
        sub=3
    fi
    local len="$(expr ${sub} + 1)"
    local full="$(print -P "%d")"
    local relfull="$(print -P "%~")"
    local shorter="$(print -P "%${len}~")"
    local current="$(print -P "%${len}(~:.../:)%${sub}~")"
    local last="$(print -P "%1~")"

    # Longer path for '~/...'
    if [[ "${shorter}" == \~/* ]]; then
        current=${shorter}
    fi

    local truncated="$(echo "${current%/*}/")"

    # Handle special case of directory '/' or '~something'
    if [[ "${truncated}" == "/" || "${relfull[1,-2]}" != */* ]]; then
        truncated=""
    fi

    # Handle special case of last being '/...' one directory down
    if [[ "${full[2,-1]}" != "" && "${full[2,-1]}" != */* ]]; then
        truncated="/"
        last=${last[2,-1]} # take substring
    fi

    echo "$(pr_color gray)${truncated}$(pr_color cyan)%B${last}%b${PR_RESET}"
}

# An exclamation point if the previous command did not complete successfully
function PR_ERROR() {
    echo "%(?..%(!.$(pr_color violet).$(pr_color red))%B!%b${PR_RESET} )"
}

# The arrow symbol that is used in the prompt
PR_ARROW_CHAR=">"

# The arrow in red (for root) or violet (for regular user)
function PR_ARROW() {
    echo "%(!.$(pr_color red).$(pr_color green))${PR_ARROW_CHAR}${PR_RESET}"
}

# Set custom rhs prompt
# User in red (for root) or violet (for regular user)
RPR_SHOW_USER=true # Set to false to disable user in rhs prompt
function RPR_USER() {
    if [[ "${RPR_SHOW_USER}" == "true" ]]; then
        echo "%(!.$(pr_color red).$(pr_color gray))%n${PR_RESET}"
    fi
}

function machine_name() {
    if [[ -f $HOME/.name ]]; then
        cat $HOME/.name
    else
        hostname
    fi
}

# Host in a muted color
RPR_SHOW_HOST=true # Set to false to disable host in rhs prompt
function RPR_HOST() {
    if [[ "${RPR_SHOW_HOST}" == "true" ]]; then
        echo "$(pr_color blue)$(machine_name)${PR_RESET}"
    fi
}

# '@' outputted only if both user and host enabled
function RPR_AT() {
    if [[ "${RPR_SHOW_USER}" == "true" ]] && [[ "${RPR_SHOW_HOST}" == "true" ]]; then
        echo "$(pr_color dim)@${PR_RESET}"
    fi
}

# Build the rhs prompt
function RPR_INFO() {
    echo "$(RPR_USER)$(RPR_AT)$(RPR_HOST)"
}

# Set RHS prompt for git repositories
DIFF_SYMBOL="*"
GIT_PROMPT_SYMBOL=""
GIT_PROMPT_PREFIX="$(pr_color dim)(${PR_RESET}"
GIT_PROMPT_SUFFIX="$(pr_color dim))${PR_RESET}"
GIT_PROMPT_AHEAD="$(pr_color teal)%B+NUM%b${PR_RESET}"
GIT_PROMPT_BEHIND="$(pr_color orange)%B-NUM%b${PR_RESET}"
GIT_PROMPT_MERGING="$(pr_color cyan)%Bx%b${PR_RESET}"
GIT_PROMPT_UNTRACKED="$(pr_color red)%B$DIFF_SYMBOL%b${PR_RESET}"
GIT_PROMPT_MODIFIED="$(pr_color yellow)%B$DIFF_SYMBOL%b${PR_RESET}"
GIT_PROMPT_STAGED="$(pr_color green)%B$DIFF_SYMBOL%b${PR_RESET}"
GIT_PROMPT_DETACHED="$(pr_color neon)%B!%b${PR_RESET}"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

function parse_git_detached() {
    if ! git symbolic-ref HEAD >/dev/null 2>&1; then
        echo "${GIT_PROMPT_DETACHED}"
    fi
}

# Show different symbols as appropriate for various Git repository states
function parse_git_state() {
    # Compose this value via multiple conditional appends.
    local GIT_STATE="" GIT_DIFF=""

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        if [[ -n $GIT_STATE ]]; then
            GIT_STATE="$GIT_STATE "
        fi
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        if [[ -n $GIT_STATE ]]; then
            GIT_STATE="$GIT_STATE "
        fi
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard :/ 2> /dev/null) ]]; then
    GIT_DIFF=$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
    GIT_DIFF=$GIT_DIFF$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
    GIT_DIFF=$GIT_DIFF$GIT_PROMPT_STAGED
    fi

    if [[ -n $GIT_STATE && -n $GIT_DIFF ]]; then
        GIT_STATE="$GIT_STATE "
    fi
    GIT_STATE="$GIT_STATE$GIT_DIFF"

    if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

# If inside a Git repository, print its branch and state
RPR_SHOW_GIT=true # Set to false to disable git status in rhs prompt
function git_prompt_string() {
    if [[ "${RPR_SHOW_GIT}" == "true" ]]; then
        local git_where="$(parse_git_branch)"
        local git_detached="$(parse_git_detached)"
        [ -n "$git_where" ] && echo " $GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX$(pr_color green)${git_where#(refs/heads/|tags/)}$git_detached$GIT_PROMPT_SUFFIX"
    fi
}

PROMPT_MODE=0
PROMPT_MODES=4

# Function to toggle between prompt modes
function tog() {
    PROMPT_MODE=$(( (PROMPT_MODE + 1) % PROMPT_MODES))
}

function PR_EXTRA() {
    # do nothing by default
}

# Show select exported environment variables

_pr_var_list=()
_vars_multiline=false

function vshow() {
    local v
    for v in "$@"; do
        if [[ "${v}" =~ '[A-Z_]+' ]]; then
            if [[ ${_pr_var_list[(i)${v}]} -gt ${#_pr_var_list} ]]; then
                _pr_var_list+=("${v}")
            fi
        fi
    done
}

function vhide() {
    local v
    for v in "$@"; do
        _pr_var_list[${_pr_var_list[(i)${v}]}]=()
    done
}

function vmultiline() {
    if $_vars_multiline; then
        _vars_multiline=false
    else
        _vars_multiline=true
    fi
}

function PR_VARS() {
    local i v spc nl
    if $_vars_multiline; then
        spc=""
        nl="\n"
    else
        spc=" "
        nl=""
    fi
    for ((i=1; i <= ${#_pr_var_list}; i++)) do
        local v=${_pr_var_list[i]}
        if [[ -v "${v}" ]]; then
            # if variable is set
            if export | grep -Eq "^${v}="; then
                # if exported, show regularly
                printf '%s' "$spc$(pr_color cyan)${v}=${(P)${v}}${PR_RESET}$nl"
            else
                # if not exported, show in red
                printf '%s' "$spc$(pr_color red)${v}=${(P)${v}}${PR_RESET}$nl"
            fi
        fi
    done
    # show project-specific vars
    while read v; do
        if [[ "${v}" =~ '[A-Z_]+' ]]; then
            # valid environment variable
            if [[ ${_pr_var_list[(i)${v}]} -gt ${#_pr_var_list} ]]; then
                # not shown yet
                if export | grep -Eq "^${v}="; then
                    # exported
                    printf '%s' "$spc$(pr_color cyan)${v}=${(P)${v}}${PR_RESET}$nl"
                fi
            fi
        fi
    done < <(git exec cat .showvars 2>/dev/null)
}

# Prompt
function PCMD() {
    if (( PROMPT_MODE == 0 )); then
        if $_vars_multiline; then
            echo "$(PR_VARS)$(PR_EXTRA)$(PR_DIR) $(PR_ERROR)$(PR_ARROW) " # space at the end
        else
            echo "$(PR_EXTRA)$(PR_DIR)$(PR_VARS) $(PR_ERROR)$(PR_ARROW) " # space at the end
        fi
    elif (( PROMPT_MODE == 1 )); then
        echo "$(PR_EXTRA)$(PR_DIR 1) $(PR_ERROR)$(PR_ARROW) " # space at the end
    else
        echo "$(PR_EXTRA)$(PR_ERROR)$(PR_ARROW) " # space at the end
    fi
}

PROMPT='$(PCMD)' # single quotes to prevent immediate execution
RPROMPT='' # set asynchronously and dynamically

function RPR_EXTRA() {
    # do nothing by default
}

# Right-hand prompt
function RCMD() {
    if (( PROMPT_MODE == 0 )); then
        echo "$(RPR_INFO)$(git_prompt_string)$(RPR_EXTRA)"
    elif (( PROMPT_MODE <= 2 )); then
        echo "$(git_prompt_string)$(RPR_EXTRA)"
    else
        echo "$(RPR_EXTRA)"
    fi
}

ASYNC_PROC=0
function precmd() {
    function async() {
        # save to temp file
        printf "%s" "$(RCMD)" > "/tmp/zsh_prompt_$$"

        # signal parent
        kill -s USR1 $$
    }

    # do not clear RPROMPT, let it persist

    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi

    # start background computation
    async &!
    ASYNC_PROC=$!
}

function TRAPUSR1() {
    # read from temp file
    RPROMPT="$(cat /tmp/zsh_prompt_$$)"

    # reset proc number
    ASYNC_PROC=0

    # redisplay
    zle && zle reset-prompt
}
