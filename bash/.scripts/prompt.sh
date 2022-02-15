#!/bin/bash

COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function is_git_branch {
  git branch > /dev/null 2>&1
}


function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_GREEN
  elif [[ $git_status =~ "working tree clean" ]]; then
    echo -e $COLOR_GREEN
  else
    echo -e $COLOR_YELLOW
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "$branch"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "$commit"
  fi
}

function git_status {
  local git_status="$(git status 2> /dev/null)"
  local staged_changes=""
  local unstaged_changes=""

  if [[ $git_status =~ "Changes not staged for commit" ]]; then
    unstaged_changes="•"
  fi
  if [[ $git_status =~ "Changes to be committed" ]]; then
    staged_changes="+"
  fi

  echo "$staged_changes$unstaged_changes"
}

function is_in_virtualenv {
  PYTHON_VENV=""
  if [ ! -z $VIRTUAL_ENV ]; then
    PYTHON_VENV="(\[$COLOR_GREEN\]`basename $VIRTUAL_ENV`\[$COLOR_WHITE\])"
  fi
}

function make_prompt {
  is_in_virtualenv

  GIT_PROMPT=""
  if is_git_branch ; then
    GIT_PROMPT="(\$(git_branch)\$(git_status))"
  fi

  PS1="${PYTHON_VENV}\[$COLOR_WHITE\][\u \w]"          # basename of pwd
  PS1+="\[\$(git_color)\]"        # colors git status
  PS1+="${GIT_PROMPT}"        # prints current branch
  PS1+="\[$COLOR_BLUE\]\$\[$COLOR_RESET\] "   # '#' for root, else '$'
}
