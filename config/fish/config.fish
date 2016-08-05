set PATH /usr/local/opt/rbenv/shims /usr/local/opt/rbenv/bin /usr/local/bin $PATH

# for rbenv
status --is-interactive; and . (rbenv init -|psub)
