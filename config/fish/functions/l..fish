function l. --description 'List dotfiles in a directory using long format'
  set files .*
  if [ (count $files) -gt 0 ]
    ll -Ad $files
  end
end
