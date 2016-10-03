# Dev Tools bashrc
#source /other/workspace/DeveloperTools/dotfiles/.bashrc

_dir_chomp () {
    local p=${1/#$HOME/\~} b s
    s=${#p}
    while [[ $p != "${p//\/}" ]]&&(($s>$2))
    do
        p=${p#/}
        [[ $p =~ \.?. ]]
        b=$b/${BASH_REMATCH[0]}
        p=${p#*/}
        ((s=${#b}+${#p}))
    done
    echo ${b/\/~/\~}${b+/}$p
}

source ~/.git-completion.bash
source ~/.git-prompt.sh
export PS1='\[\e[1;31m\][ \u@\h:\[\e[1;36m\] $(_dir_chomp "$(pwd)" 20 )$(__git_ps1 " (%s)") : \[\e[1;31m\]\t ] \[\e[0m\]$ '
export JAVA_HOME=/opt/jdk
export PATH=$JAVA_HOME/bin:$PATH
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTCONTROL=ignoredups
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

#-------------------------------------------------------------
# Start Personal .bashrc stuff
# if not running interactively, don't do anything
#-------------------------------------------------------------
if [ -z "$PS1" ]; then return; fi
case $- in *i*)
#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------

if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi

# Smart cd corrects for some mispelling
shopt -s cdspell

# Source bash functions and aliases
source ~/.bash_aliases
source ~/.bash_functions
handle_dev_environment;
#alias_completion;

esac;
