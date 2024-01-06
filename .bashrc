# Personal bash configuration file

if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

export ANDROID_SDK=$HOME/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_SDK

export PERSONAL_BIN=$HOME/mybin

ADDITIONAL_PATHS=(
	$PERSONAL_BIN
	$ANDROID_SDK/platform-tools
	$ANDROID_SDK/emulator
	$HOME/.dotnet
)

for add_path in ${ADDITIONAL_PATHS[*]}; do
   if [ -d $add_path ]; then
      export PATH=$add_path:$PATH
   fi
done

set completion-ignore-case On

shopt -s autocd
shopt -s direxpand
shopt -s globasciiranges globstar dotglob
shopt -s interactive_comments
shopt -s lithist

export DOTNET_ROOT=$HOME/.dotnet
export EDITOR=nvim
export PAGER=less

export LESS='-r'
export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=erasedups:ignoredups

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# generate dircolors for coloring completion and commmands like ls
[ -f ~/.dircolors ] && eval "$(dircolors ~/.dircolors)"

two_part_path() { pwd | awk 'BEGIN{FS="/"; OFS="/"} { print $(NF - 1), $NF }'; }

PS1="\[\e[38;5;97;3m\]\u@\h\[\e[0m\]:(\[\e[38;5;220m\]\$(two_part_path)\[\e[0m\])\$ "

source_folder_in_path() {
	IFS_SAVE=$IFS
	IFS=:
	for source_path in $PATH; do
		if [ -d "$source_path/$1" ]; then
			IFS=$IFS_SAVE
			for file in $(ls $source_path/$1); do
				FILE=$source_path/$1/$file
				[ -f $FILE ] && source $FILE
			done
		fi
	done
	IFS=$IFS_SAVE
}

source_folder_in_path completions
source_folder_in_path plugins
