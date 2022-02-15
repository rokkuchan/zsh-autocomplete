#!/bin/bash

#Auto complete
_venv_options='$(ls $HOME/.venvs)'
complete -W "${_venv_options}" 'venv-activate' 
complete -W "${_venv_options}" 'venv-remove' 


function venv-make()
{
  set -e 
  if [ -z "$1" ]; then
    echo "No Args Supplied"
    return
  fi
  if [ -d $HOME/.venvs/$1 ]; then
    echo "venv already exists"
    return
  fi
  
  python3 -m venv $HOME/.venvs/$1
  echo -e "Activate venv with:\n\tsource $HOME/.venvs/$1/bin/activate\n"
}

function venv-activate()
{
  if [ -z "$1" ]; then
    echo "Available Venvs:"
    for i in $HOME/.venvs/*; do echo -e "\t- $i"; done;
    return
  fi
  if [ ! -d $HOME/.venvs/$1 ]; then
    echo "Invalid venv: $1"
    return
  fi

  source $HOME/.venvs/$1/bin/activate
}

function venv-remove()
{
  if [ -z "$1" ]; then
    echo "Available Venvs:"
    for i in $HOME/.venvs/*; do echo -e "\t- $i"; done;
    return
  fi
  if [ ! -d $HOME/.venvs/$1 ]; then
    echo "Invalid venv: $1"
    return
  fi

  rm -r $HOME/.venvs/$1/
}