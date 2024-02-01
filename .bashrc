# Personal bash configuration file

if [ -f /usr/share/bash-completion/bash_completion ]; then
	source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion
fi

[ -f ~/.bash/aliases.sh ] && . ~/.bash/aliases.sh
[ -f ~/.bash/options.sh ] && . ~/.bash/options.sh

# generate dircolors for coloring completion and commmands like ls
[ -f ~/.dircolors ] && eval "$(dircolors ~/.dircolors)"

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
