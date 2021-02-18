function rg --wraps rg --description 'ripgrep'
  command rg --type-add 'css:*.{scss,sass}' --type-add 'ruby:*.rake' --smart-case $argv
end
