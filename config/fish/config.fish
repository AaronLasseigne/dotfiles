set -U EDITOR 'nvim -p'
set -U FZF_DEFAULT_COMMAND 'rg --smart-case --files --no-ignore --hidden --follow --glob "!.git/*"'
set -U FZF_DEFAULT_OPTS '--preview "begin; cat {}; or tree -C {}; end 2> /dev/null | head -200"'

# install plugins
set plugins done imgcat rbenv segment
for plugin in $plugins
  if [ -z (fisher ls | grep $plugin) ]
    fisher $plugin
  end
end

set PATH ~/bin $PATH
