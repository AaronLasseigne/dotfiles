RED_FG="%{$FG[250]%}"
RED_BG="%{$BG[088]%}"
RED_FG_ARROW="%{$FG[088]%}"
GREEN_FG="%{$FG[022]%}"
GREEN_BG="%{$BG[148]%}"
GREEN_FG_ARROW="%{$FG[148]%}"
BLUE_FG="%{$fg[white]%}"
BLUE_BG="%{$BG[024]%}"
BLUE_FG_ARROW="%{$FG[024]%}"
LIGHT_BLUE_FG="%{$FG[024]%}"
LIGHT_BLUE_BG="%{$BG[117]%}"
LIGHT_BLUE_FG_ARROW="%{$FG[117]%}"
WHITE_FG="%{$fg[white]%}"
WHITE_BG="%{$bg[white]%}"
WHITE_FG_ARROW="%{$fg[white]%}"
GREY_FG="%{$FG[240]%}"
GREY_BG="%{$BG[240]%}"

ZSH_THEME_GIT_PROMPT_PREFIX="$LIGHT_BLUE_BG$LIGHT_BLUE_FG ∓ "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}$LIGHT_BLUE_FG_ARROW%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" $RED_FG_ARROW+"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_current_branch() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$LIGHT_BLUE_BG$BLUE_FG_ARROW%{$reset_color%}$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  else
    echo "%{$reset_color%}$BLUE_FG_ARROW%{$reset_color%}"
  fi
}

# rbenv plugin for oh-my-zsh is broken
alias rubies="rbenv versions"
alias gemsets="rbenv gemset list"

function current_ruby() {
  echo "$(rbenv version-name)"
}

function current_gemset() {
  echo "$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)"
}

function gems {
  local rbenv_path=$(rbenv prefix)
  gem list $@ | sed \
    -Ee "s/\([0-9\.]+( .+)?\)/$fg[blue]&$reset_color/g" \
    -Ee "s|$(echo $rbenv_path)|$fg[magenta]\$rbenv_path$reset_color|g" \
    -Ee "s/$current_ruby@global/$fg[yellow]&$reset_color/g" \
    -Ee "s/$current_ruby$current_gemset$/$fg[green]&$reset_color/g"
}

function rbenv_prompt_info() {
  if [[ -n $(current_gemset) ]] ; then
    echo "$(current_ruby)@$(current_gemset)"
  else
    echo "$(current_ruby)"
  fi
}

PROMPT='
$RED_BG$RED_FG $(rbenv_prompt_info) $BLUE_BG$RED_FG_ARROW$BLUE_FG %~ $(git_current_branch)
> '
