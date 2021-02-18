function df --wraps df --description 'Disk space with human readable output'
  command df -H $argv
end
