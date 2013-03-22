# skips dupes when using up/down arrows to look through your history
setopt HIST_FIND_NO_DUPS

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

# vim now accepts file:line#
v() {
  output=${*/:/ +}
  vim ${=output}
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

# ree vars
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000

export TESTS_WITH_GUSTO=1
