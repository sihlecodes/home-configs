# Personal bash configuration file

. /usr/share/bash-completion/bash_completion

if ! [[ $PATH =~ mybin ]]; then
	export PATH=$HOME/mybin:$HOME/bin:$PATH
fi

export EDITOR=vim
export PAGER=less
export HISTCONTROL=ignoredups

export HISTSIZE=1000
export HISTFILESIZE=2000
export HISTCONTROL=erasedups:ignoredups

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# generate dircolors for coloring completion and commmands like ls
[ -f ~/.dircolors ] && eval "$(dircolors ~/.dircolors)"

two_part_path() { pwd | awk 'BEGIN{FS="/"; OFS="/"} { print $(NF - 1), $NF }'; }

PS1="\[\e[38;5;97;3m\]\u@\h\[\e[0m\]:(\[\e[38;5;161m\]\$(two_part_path)\[\e[0m\])\$ "

source_folder_in_path() {
	IFS_SAVE=$IFS
	IFS=:
	for path in $PATH; do
		if [ -d $path/$1 ]; then
			IFS=$IFS_SAVE
			for file in $(ls $path/$1); do
				COMPLETION_FILE=$path/$1/$file
				[ -f $COMPLETION_FILE ] && source $COMPLETION_FILE
			done
		fi
	done
	IFS=$IFS_SAVE
}

source_folder_in_path completions
source_folder_in_path plugins