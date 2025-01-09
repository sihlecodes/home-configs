# General
# enable color support of ls and also add handy aliases

alias ls='ls -a --color=auto'
alias la='ls -hs'
alias ll='ls -l'

function lp() {
    ls --color=yes -l $@ | awk '{ print $1, $9, $10, $11 }'
}

CXX_FLAGS="-Wall -Wunreachable-code -Werror"

function gpp() {
   if [ $# -eq 1 ]; then
      clang++ $CXX_FLAGS -o ${1//.cpp/} $1
      return;
   fi
   
   if [ $# -gt 1 ]; then
      clang++ $CXX_FLAGS -o main $@
      return;
   fi
}

alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias echo='echo -e'

alias cp='cp -rv'
alias dd='dd status=progress'
alias rrm='\rm -rfv'
alias rm='trash add'
alias mkdir='mkdir -pv'

alias ebrc="${EDITOR:-nvim} ~/.bashrc"
alias sbrc='. ~/.bashrc'

alias ebp="${EDITOR:-nvim} ~/.bash_profile"
alias sbp='. ~/.bash_profile'

# WSL niceties

if [ -n "$(which adb.exe 2>/dev/null)" ]; then
    alias adb=adb.exe
fi
