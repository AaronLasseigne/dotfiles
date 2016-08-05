function bak -a file --description 'Make a quick backup of a file'
  set timestamp (date +%Y%m%d%H%M%S)
  cp $file "$file.$timestamp"
end
