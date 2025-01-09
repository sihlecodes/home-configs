if [[ -z $PERSONAL_BIN ]]; then
   PERSONAL_BIN=$HOME/bin
fi

_binmgr_complete()
{
   cword=${COMP_WORDS[$COMP_CWORD]}
   action=${COMP_WORDS[1]}

   if [ $COMP_CWORD -eq 1 ]; then
      actions='--create --chmod --list --edit --help --directory'
      COMPREPLY=($(compgen -W "$actions" -- "$cword"))
      return

   elif [[ $cword =~ '-' ]]; then
      COMPREPLY=--create

   elif [[ '-e|--edit|-x|--chmod' =~ $action ]]; then
      COMPREPLY=($(compgen -o filenames -f $PERSONAL_BIN/"$cword" | xargs -n 1 basename))
   fi
}

complete -F _binmgr_complete -o nospace bin
