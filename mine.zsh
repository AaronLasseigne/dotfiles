# skips dupes when using up/down arrows to look through your history
setopt HIST_FIND_NO_DUPS

export EDITOR=vim
# human readable sizes
alias df="df -H"

# human readable sizes and a total
alias du="du -hc"

# create sub directories all at once
alias mkdir="mkdir -p"

# add tabs
alias vim="vim -p"

# list with human readable sizes
alias ll='ls -lh'

# list only dot files/directories
alias l.='ll -Ad \.*'

# ignore case when searching
alias less='less -i'

# man is supposed to default to this but case insensitive search isn't working
alias man='man -P "less -is"'

# force 246 color tmux
alias tmux='tmux -2'

alias g="git"
alias rspec="bundle exec rspec -c -f doc"

# fixes issues when using ssh inside tmux
alias ssh='TERM=xterm-256color ssh'

alias brewit='brew update && brew outdated'

# create a quick backup
bak() {
  timestamp=`date +%Y%m%d%H%M%S`
  cp $1 "$1.$timestamp"
}

# make directory and change
mdc() { 
  mkdir $1 
  cd $1
}

# vim now accepts file:line#
v() {
  output=${*/:/ +}
  vim ${=output}
}
