function rg --wraps 'rg'
  command rg --type-add 'css:*.{scss,sass}' --smart-case $argv
end
