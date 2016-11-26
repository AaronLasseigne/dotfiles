set -U EDITOR nvim
set -U FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# install plugins
set plugins segment
for plugin in $plugins
  if [ -z (fisher ls | grep $plugin) ]
    fisher $plugin
  end
end

# for rbenv
if [ (which rbenv) ]
  status --is-interactive; and . (rbenv init -|psub)
end

set PATH ~/bin $PATH
