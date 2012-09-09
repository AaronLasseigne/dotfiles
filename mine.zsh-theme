collapse_hostname() {
  echo $(hostname | sed -e "s,^.*\.local,local,")
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$BG[117]%}%{$FG[024]%} ∓ "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}+ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_current_branch() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
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

RPROMPT='%{$reset_color%}%{$bg[white]%}%{$FG[240]%} %D{%X}%  %{$BG[240]%}%{$fg[white]%} %D{%Y-%m-%d}%f %{$reset_color%}'

PROMPT='
%{$BG[088]%}%{$FG[250]%} $(rbenv_prompt_info) %{$BG[148]%}%{$FG[022]%} $(collapse_hostname) %{$fg[white]%}%{$BG[024]%} %~ %{$reset_color%}$(git_current_branch)
> '
