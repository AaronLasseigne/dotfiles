[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# aliases
alias df="df -h"
alias du="du -h"
alias g="git"
alias mkdir="mkdir -p"
alias v="vim -p"
alias rspec="bundle exec rspec -c -f doc"
alias ll='ls -lh'
alias l.='ll -Ad \.*'
alias rc='pry -r ./config/environment'
alias less='less -i'

# custom functions
bak() {
  timestamp=`date +%Y%m%d%H%M%S`
  cp $1 "$1.$timestamp"
}

mdc() { 
  mkdir $1 
  cd $1
}
