function direnv --wraps direnv --description 'direnv'
  command asdf exec direnv $argv
end
