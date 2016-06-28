# For code building
alias cm="roscd && catkin_make"

# Rostopic tools
alias rtl="rostopic list"
alias rth="rostopic hz"

alias tf_view='cd /var/tmp && rosrun tf view_frames && evince frames.pdf &'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color=auto'
alias diff='colordiff'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.

# Going up the file tree aliases
alias b="cd .."
alias bb="cd ../.."
alias bbb="cd ../../.."
alias bbbb="cd ../../../.."

# Counts number of threads a PID has
alias threads="ps -o nlwp"

# Git shortcuts
alias gs="git status"
alias gl="git log"
alias gc="git commit"
alias gb="git branch"
alias gt="git tag"
alias gco="git checkout"
alias ga="git add"
alias gd="git diff"
alias grm="git rm"
alias grb="git rebase"
alias gmv="git mv"
alias gpl="git pull"
alias gpsh="git push"
alias gup="git-set-upstream"
