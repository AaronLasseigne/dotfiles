function l. --description 'List dotfiles in a directory using long format'
  set files .*
  if [ (count $files) -gt 0 ]
    exa -l --group-directories-first --no-user --all --ignore-glob='[a-zA-Z0-9]*'
  end
end
