# Personal bash configuration file

source /etc/bash_completion

export ANDROID_SDK=$HOME/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_SDK

ADDITIONAL_PATHS=(
   $HOME/mybin
   $ANDROID_SDK/platform-tools
   $ANDROID_SDK/emulator
   $HOME/.dotnet
)

for add_path in ${ADDITIONAL_PATHS[*]}; do
   export PATH=$add_path:$PATH
done

export DOTNET_ROOT=$HOME/.dotnet
export EDITOR=vim
export PAGER=less

export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=erasedups:ignoredups

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# generate dircolors for coloring completion and commmands like ls
[ -f ~/.dircolors ] && eval "$(dircolors ~/.dircolors)"

two_part_path() { pwd | awk 'BEGIN{FS="/"; OFS="/"} { print $(NF - 1), $NF }'; }

PS1="\[\e[38;5;99;3;1m\]\u@\h\[\e[0m\]:(\[\e[38;5;214;1m\]\$(two_part_path)\[\e[0m\])\$ "

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