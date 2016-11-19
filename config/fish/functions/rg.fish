function rg --wraps 'rg'
  command rg --type-add 'css:*.{scss,sass}' $argv
end
