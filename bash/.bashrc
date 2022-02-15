# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAG`
export JAVA_HOME="/etc/alternatives/java_sdk_11_openjdk"
export LESS="-misXR"
LD_LIBRARY_PATH="/usr/local/lib/:usr/lib/:/usr/lib64/"
export WORKON_HOME="~/.venvs/"
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
# ---
# MIXR root
# ---
export MIXR_HOME=/local/mixr-platform
export MIXR_ROOT=$MIXR_HOME/mixr
export MIXR_DATA_ROOT=$MIXR_HOME/mixr-data
export MIXR_3RD_PARTY_ROOT=$MIXR_HOME/mixr-3rdparty
export MIXR_EXAMPLES_ROOT=$MIXR_HOME/mixr-examples
export MIXR_EXAMPLES_LIB_PATH=$MIXR_EXAMPLES_ROOT/lib

LD_LIBRARY_PATH=$MIXR_3RD_PARTY_ROOT/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH
export OSPL_HOME=/home/nathan/workspace/oaris/HDE/x86_64.linux
# ---
# Update path to search for binaries in our 3rd party library path
# ---
export PATH=$MIXR_3RD_PARTY_ROOT/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$OSPL_HOME/bin:$PATH
# User specific aliases and functions
alias ..='cd ..'

function nexus_upload()
{
  sudo rm /local/packages -r
  sudo cp /run/media/fowlern/NEXUS_TRANSFER/packages /local/packages -r
  sudo chown fowlern:fowlern /local/packages -R
  upload-packages -u /local/packages
}

function pypi_upload()
{
  if [ -f "$1" ]; then
    twine upload --repository-url http://nexus:7081/repository/pypi-internal/ -u admin -p admin123 $1
  fi
}

#External Scripts
source $HOME/.scripts/prompt.sh

#VirtualEnvWrapper Script
source $HOME/.local/bin/virtualenvwrapper.sh

PROMPT_COMMAND=make_prompt
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
