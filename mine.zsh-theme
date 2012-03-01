collapse_hostname() {
  echo $(hostname | sed -e "s,^.*\.local,local,")
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$fg[white]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_current_branch() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo " $ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

GREEN=$'\e[0;32m'
BLUE=$'\e[1;34m'
RED=$'\e[1;31m'

# PROMPT='%{$GREEN%}%D{%L:%M}%{$reset_color%} %{$RED%}$(collapse_hostname)%{$fg[white]%}:%{$BLUE%}%~%{$reset_color%}$(git_current_branch) ) '
PROMPT='%{$GREEN%}%D{%L:%M}%{$reset_color%} %{$RED%}$(collapse_hostname)%{$fg[white]%}:%{$BLUE%}%~%{$reset_color%} ) '
