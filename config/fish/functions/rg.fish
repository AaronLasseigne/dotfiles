function rg --wraps 'rg'
  command rg --type-add 'css:*.{scss,sass}' --type-add 'ruby:*.rake' --smart-case $argv
end
