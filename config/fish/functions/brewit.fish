function brewit --description 'Look for new brew updates'
  brew update; and brew outdated
end
