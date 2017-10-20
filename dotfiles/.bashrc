# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export EDITOR='vim'

export PATH=$PATH":~/bin/"

##COLOR DEF BEGIN
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend
#give bash tcsh history completion
bind '"\e[B": history-search-forward'
bind '"\e[A": history-search-backward'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=100000
#HISTFILESIZE=200000
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

export PROMPT_COMMAND=__prompt_command  # Func to gen PS1 after CMDs

function __prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1="\n"
    local RCol='\[\e[0m\]'
    local Red='\[\e[0;31m\]'
    local BRed='\[\e[1;31m\]' 
    local BWht='\[\e[1;37m\]'
    local Grn='\[\e[0;32m\]'
    local BGrn='\[\e[1;32m\]'
    local Gry='\[\e[0;37m\]'
    local DGry='\[\e[1;30m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'
    local BPur='\[\e[1;35m\]'
    local BCya='\[\e[1;36m\]'
    local Brwn='\[\e[0;33m\]'
    local star=`echo -e "\xE2\x9b\xA4"`
    local timestamp=`date +"%H:%M:%S"`
    local dateee=`date +"%F"`
    local username="$BGrn\u$RCol"
    local hostname="$Brwn\h$RCol"

    if [ $EXIT != 0 ]; then
      PS1+="$BRed$timestamp$RCol$BYel$star$RCol $BGry$dateee$RCol"
    else
      PS1+="$Pur$timestamp$RCol$BYel$star $Gry$dateee$RCol"
    fi

#    PS1+="{RCol}@${BBlu}\h ${Pur}\W${BYel}$ ${RCol}"
    PS1+="\n${debian_chroot:+($debian_chroot)}$username@$hostname:$BCya\w$RCol\n$"
}



if [[ $? -ne 0 ]]; then
    PS1="\[\e[0;31m\]\@\[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n$ "
else
    PS1="\[\e[1;34m\]\@\[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n$ "
fi
unset color_prompt force_color_prompt


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#This forces history file to be written after each command so that each
#active session will have the same history. Also avoids
#clobbering
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}
