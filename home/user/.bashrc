#!/bin/bash
# .bashrc

# If this isn't an interactive prompt don't do anything
#[ -z "$PS1" ] && return

# Source global definitions 
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# set color mode (mobaxterm and putty fix)
if [[ $TERM == xterm ]]; then
    TERM="xterm-256color"
fi

# User specific aliases and functions
source ~/bin/git-completion.bash
source ~/bin/git-prompt.sh

source $HOME/go/src/github.com/Novetta/pwcop/dev/ares_dev.env



################################################################################
# General EXPORTs
################################################################################
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export NOVETTA_PATH=$HOME/go/src/github.com/Novetta
export KLE_MIGRATE_DIR=$NOVETTA_PATH/KLE/setup
export KLE_UPDATE_CASSANDRA="127.0.0.1:9042"
export USE_LIBRE="true"
export PATH=/home/jwalton/bin:$PATH
export PATH=/usr/lib/node/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH="$HOME/bin/Sencha/Cmd/6.1.3.42/..:$PATH"
export AUTH_METHOD="digest"
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export PYTHONPATH='/usr/lib/python2.7/site-packages/':$PYTHONPATH
export COMMON=$NOVETTA_PATH/common
export KERBPROXY=$NOVETTA_PATH/kerbproxy


################################################################################
# ALIAS
################################################################################
alias common='cd $NOVETTA/common'
alias resource='source ~/.bashrc'
alias cqlsh='cqlsh'

alias senchify='sencha app build development'
alias watchify='sencha app watch'
alias submod='git submodule update --init --recursive'
alias ares-fbncjs='cd $NOVETTA/pwcop/aresweb/packages/fbncjs'

# Ares COT 
alias executor='go run $NOVETTA/common/executor/distexecutor/distexecutorservice/main.go'
alias recorder='go run $NOVETTA/pwcop/lib/recorder/recorder.go'
alias geosub='go run $NOVETTA/pwcop/lib/geosub/geosubscriptions/main.go'
alias generator='go run $NOVETTA/common/generator/cot_generator/main.go -outIp 234.6.7.8:3456'

# Python 2.7 (req. for Cassandra 2.2.8+)
alias pythonexportpath='export PYTHONPATH="/usr/lib/python2.7/site-packages/":$PYTHONPATH'
alias pythonswitch='scl enable python27 bash'



################################################################################
# Nice colorized git prompt for bash
################################################################################
function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=42
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=43
        else
            local ansi=41
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

# RED="\[\033[0;31m\]"
# GREEN="\[\033[0;32m\]"
# LIGHT_GRAY="\[\033[0;37m\]"
# CYAN="\[\033[0;36m\]"
# BLACK="\[\033[0;30m\]" 
# BLUE="\[\033[0;34m\]"         

function _prompt_command() {
    PS1="`_git_prompt`"'[\u \t \[\033[0;34m\]\w\[\033[0;30m\]]\$\[\e[0m\] '
}
#PROMPT_COMMAND=_prompt_command #opt 1 - git status/ branch
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ ' #opt 2 - git branch 

alias ares='cd $NOVETTA/pwcop'
alias fms='cd $NOVETTA/fms'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
