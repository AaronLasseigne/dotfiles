function ll --wraps eza --description 'List contents of directory using long format and human readable sizes'
  eza -l --group-directories-first --no-user $argv
end
