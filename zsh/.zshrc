# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/nathan/.zshrc'
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep

LANG="en_US.UTF-8"
LC_COLLATE="en_US.UTF-8"
LC_CTYPE="en_US.UTF-8"
LC_MESSAGES="en_US.UTF-8"
LC_MONETARY="en_US.UTF-8"
LC_NUMERIC="en_US.UTF-8"
LC_TIME="en_US.UTF-8"
LC_ALL="en_US.UTF-8"

bindkey -v
# End of lines configured by zsh-newuser-install

source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}"  delete-char
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-history
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-history
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" end-of-buffer-or-history

if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

#Alias
alias ls="ls --color=always"
alias ll="ls -l"
alias lt="ls -ltr"
alias lla="ll -a"
alias ..="cd .."
export PATH="/home/nathan/.local/bin:$PATH"
if command -v go >/dev/null 2>&1; then
  export PATH="$PATH:/usr/local/go/bin"
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

export GOSUMDB="sum.golang.org https://nexus.au.lmco.com/repository/gosum-proxy"
export GOPROXY="https://nexus.au.lmco.com/repository/golang-proxy"
export JAVA_HOME="/etc/alternatives/java_sdk_11_openjdk"
export WORKON_HOME="~/.venvs/"
export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"

source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

bindkey "^[[1~"  beginning-of-line
bindkey "^[[4~"  end-of-line
bindkey "^[[H"   beginning-of-line
bindkey "^[[F"   end-of-line


#VirtualEnvWrapper Script
if [ -f $HOME/.local/bin/virtualenvwrapper.sh ]; then
  source $HOME/.local/bin/virtualenvwrapper.sh
fi

function build_image() {
  docker build -t $1 --build-arg "NEXUS_CI_USERNAME=soar-itar-gitlab" --build-arg "NEXUS_CI_PASSWORD=changeme" .
}

## Prompt stuff
function set_win_title(){
  echo -ne "\033]0; $(hostname):/$(basename $PWD) \007"
}

precmd_functions+=(set_win_title)
eval "$(starship init zsh)"
