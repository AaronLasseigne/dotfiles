function ll --wraps ls --description 'List contents of directory using long format and human readable sizes'
  ls -lho $argv 
end
