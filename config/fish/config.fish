set fish_greeting

set -x EDITOR 'nvim -p'
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_DEFAULT_OPTS '--preview "begin; bat {} --color=always; or tree -C {}; end 2> /dev/null | head -200"'

source (brew --prefix asdf)/asdf.fish
# to put brew installs before system installs
set -g fish_user_paths "/usr/local/bin" "/usr/local/sbin" $fish_user_paths

if test -e ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end
