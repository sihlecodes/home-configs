# created: 18 Jan 2024

export ANDROID_SDK=$HOME/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_SDK
export DOTNET_ROOT=/snap/dotnet-sdk/current

export TEXLIVE_PATH=/usr/local/texlive/2024/bin/x86_64-linux
export PERSONAL_BIN=$HOME/mybin

ADDITIONAL_PATHS=(
	$PERSONAL_BIN
	$ANDROID_SDK/platform-tools
	$ANDROID_SDK/emulator
   $DOTNET_ROOT
   $TEXLIVE_PATH
)

for extra in ${ADDITIONAL_PATHS[*]}; do
   if [ -d $extra ]; then
      export PATH=$extra:$PATH
   fi
done

set completion-ignore-case On

shopt -s autocd
shopt -s direxpand
shopt -s globasciiranges globstar dotglob
shopt -s interactive_comments
shopt -s lithist

export EDITOR=nvim
export PAGER=less
export LESS='-r'
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=erasedups:ignoredups

two_part_path() { pwd | awk 'BEGIN{FS="/"; OFS="/"} { print $(NF - 1), $NF }'; }

PS1="\[\e[38;5;105m\]\u@\h\[\e[0m\]:(\[\e[38;5;220m\]\$(two_part_path)\[\e[0m\])\$ "
