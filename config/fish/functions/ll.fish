function ll --wraps exa --description 'List contents of directory using long format and human readable sizes'
  exa -l --group-directories-first --no-user $argv
end
