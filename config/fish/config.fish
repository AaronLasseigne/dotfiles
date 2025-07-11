set fish_greeting

set -x EDITOR 'nvim -p'
set -x BAT_THEME 'gruvbox-dark'
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow --glob "!.git/*"'
set -x FZF_DEFAULT_OPTS '--preview "begin; bat --color=always --style=numbers {}; or tree -C {}; end 2> /dev/null | head -200"'

eval "$(/opt/homebrew/bin/brew shellenv)"

# ASDF configuration code
if test -z $ASDF_DATA_DIR
  set _asdf_shims "$HOME/.asdf/shims"
else
  set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
  set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

fish_add_path ~/bin

if test -e ~/.config/fish/config.local.fish
  source ~/.config/fish/config.local.fish
end

asdf exec direnv hook fish | source
