set fish_greeting

set -x EDITOR 'nvim -p'
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_DEFAULT_OPTS '--preview "begin; bat {} --color=always; or tree -C {}; end 2> /dev/null | head -200"'

source /usr/local/opt/asdf/asdf.fish

fish_add_path ~/bin

if test -e ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end

asdf exec direnv hook fish | source
