# skips dupes when using up/down arrows to look through your history
setopt HIST_FIND_NO_DUPS

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

alias git="hub"
alias g="git"
alias rspec="bundle exec rspec -c -f doc"

rails() {
  if [[ "$1" == 'pry' ]]; then
    pry -r ./config/environment
  else
    bundle exec rails $*
  fi
}

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

va() {
  match=`ack --no-color -1 $* | head -n1 | cut -d: -f1,2`

  if [[ "$match" != '' ]]; then
    output=("${(s/:/)match}")
    vim $output[1] +$output[2]

    echo $output[1]
  else
    echo 'No matches found.'
  fi
}

export EDITOR=vim
