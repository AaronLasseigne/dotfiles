set -x EDITOR 'nvim -p'
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_DEFAULT_OPTS '--preview "begin; cat {}; or tree -C {}; end 2> /dev/null | head -200"'

# install plugins
set plugins 'franciscolourenco/done' 'daenney/rbenv' 'jorgebucaran/fish-segment'
for plugin in $plugins
  if [ -z (fisher ls | grep $plugin) ]
    fisher add $plugin
  end
end

set PATH ~/bin (yarn global bin) $PATH
