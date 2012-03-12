# human readable sizes
alias df="df -H"

# human readable sizes
alias du="du -h"

# create sub directories all at once
alias mkdir="mkdir -p"

# add tabs
alias v="vim -p"

# list with human readable sizes
alias ll='ls -lh'

# list only dot files/directories
alias l.='ll -Ad \.*'

# ignore case when searching
alias less='less -i'
alias ack='ack -i'

alias g="git"
alias rspec="bundle exec rspec -c -f doc"
alias rc='pry -r ./config/environment'

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
