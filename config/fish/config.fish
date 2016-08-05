# install plugins
set plugins segment
for plugin in plugins
  if [ (fisher ls | grep $plugin) ]
    fisher $plugin
  end
end

set PATH /usr/local/opt/rbenv/shims /usr/local/opt/rbenv/bin /usr/local/bin $PATH

# for rbenv
status --is-interactive; and . (rbenv init -|psub)