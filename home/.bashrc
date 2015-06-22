RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"

PATH=$PATH:$HOME/bin:/usr/sbin
export PATH

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export LS_COLORS=gxBxhxDxfxhxhxhxhxcxcx

export EDITOR="emacs"

fateproc(){
  sudo ps aux| grep server | grep -v grep | awk '{ print $2 }' | xargs kill
  $@
}

jiraprefix(){
  prefix=""
  env_re="[0-9]+"
  jira_re="[^/]*/?([0-9]{3,4}).*"
  if [[ $(__git_ps1) =~ $jira_re ]]; then prefix="GP-${BASH_REMATCH[1]}"; else
      if [[ "${JIRA_NUM}" =~ $env_re ]]; then
          prefix="GP-${JIRA_NUM}"
      else
          prefix="";
      fi
  fi
  echo "$prefix "
}

ngrepl() {
  echo "> sudo ngrep -W byline -d lo port $1"
  sudo ngrep -W byline -d lo port $1
}

worker() {
  sudo ssh -i ~/.ssh/twogem-worker ubuntu@$1
}

mfind(){
  find "$1" -type f -exec grep -iIHn "$2" {} \;
}

dec(){
  find ~/encrypted/ -type f -name "*${1}*.gpg" -exec gpg -d {} \;
}

g(){
  echo "> git $@"
  git "$@"
}

ga(){
  g add "$@"
}

gr(){
  g reset HEAD "$@"
}

gm(){
  g merge "$@"
}

psh(){
  g push "$@"
}

psho(){
  if [ $# -eq 0 ]
  then
    psh origin HEAD
  else
    psh origin "$@"
  fi
}

pll(){
  g pull "$@"
}

pllo(){
  if [ $# -eq 0 ]
  then
    pll origin HEAD
  else
    pll origin "$@"
  fi
}

gca(){
  g commit -a "$@"
}

gb(){
  g branch "$@"
}

gc(){
  if [ $# -eq 0 ]
  then
    g commit
  else
    g commit "${@: 1:$#-1}" -m "${@: -1}"
  fi
}

gd(){
  g diff "$@"
}

gchk(){
  g checkout "$@"
}

gl(){
  g log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit
}

glp() {
  if [ $# -eq 0 ]
  then
    g log -p --stat
  else
    g log -p -$1 --stat
  fi
}

gs(){
  echo '> git status'
  git status
}

up(){
  local d=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
    do
      d=$d/..
    done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

alias ll='ls -la'
alias cp='rsync -aP'
# I'm bad at typing
alias eamcs='emacs'
alias emac='emacs'
alias emcas='emacs'
alias emasc='emacs'
alias flag='toilet -f mono12 '

alias cc="drush rr && drush cc all"
alias ccfg="drush rr && drush cc all && fg"
alias dl="tail -f /tmp/drupal_debug.txt"
alias rmpyc="find . -type f -name '*.pyc' -exec rm {} \;"
alias rmtilda="find . -name '*~' -exec rm {} \;"
alias cltr="rmpyc; rmtilda"
alias remount="sudo kextunload /System/Library/Extensions/AppleStorageDrivers.kext/Contents/PlugIns/AppleUSBCardReader.kext && sudo kextload /System/Library/Extensions/AppleStorageDrivers.kext/Contents/PlugIns/AppleUSBCardReader.kext"
alias clearberks='rm -rf ~/.berkshelf/vagrant-berkshelf/shelves/*'
alias roundpy='gemp && cd roundpy'
alias bashrc='source ~/.bashrc'

export PYTHONSTARTUP=~/.pythonrc

export RBENV_ROOT="${HOME}/.rbenv"; if [ -d "${RBENV_ROOT}" ]; then export PATH="${RBENV_ROOT}/bin:${PATH}"; eval "$(rbenv init -)"; fi

source ~/.git-prompt.sh
PS1="$RED\w$YELLOW\$(__git_ps1)$GREEN\$ "

if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    __git_complete g __git_main
    __git_complete gc _git_commit
    __git_complete gchk _git_checkout
    __git_complete gm _git_merge
    __git_complete pll _git_pull
    __git_complete psh _git_push
fi


if [ ! -e "${HOME}/.local/bin/virtualenvwrapper.sh" ]; then
    if [ ! -e "${HOME}/virtualenvwrapper.sh" ]; then
        if [ ! -e "/usr/local/bin/virtualenvwrapper.sh" ]; then
            pip install --user virtualenv
            pip install --user virtualenvwrapper
        fi
    fi
fi

export WORKON_HOME=~/Envs

if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
    source /usr/local/bin/virtualenvwrapper.sh
    workon py
fi


if [ -f "${HOME}/.local/bin/virtualenvwrapper.sh" ]; then
    source ~/.local/bin/virtualenvwrapper.sh
    export PATH="$PATH:${HOME}/.local/bin"
    workon py
fi

if [ -f "${HOME}/virtualenvwrapper.sh" ]; then
    source ~/virtualenvwrapper.sh
    workon py
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:${HOME}/.local/bin:$PATH"

### For tx, bx, and ku (pycoin cli tools)
PYCOIN_CACHE_DIR=~/.pycoin_cache
PYCOIN_SERVICE_PROVIDERS=BLOCKR_IO:BLOCKCHAIN_INFO:BITEASY:BLOCKEXPLORER
export PYCOIN_CACHE_DIR PYCOIN_SERVICE_PROVIDERS
