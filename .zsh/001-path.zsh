##PATH
paths_file="$HOME/.zsh_paths"
#上から優先したいので逆順に頭に追加
if [ -f $paths_file ] ;then
    for binpath in $(tac "$paths_file") ;do
        if [ -d "$binpath" ] ; then
            PATH="$binpath:$PATH"
        fi
    done
fi
##MANPATH
manpaths_file="$HOME/.zsh_manpaths"
if [ -f $manpaths_file ] ;then
    for binmanpath in $(tac "$manpaths_file") ;do
        if [ -d "$binmanpath" ] ; then
            MANPATH="$binmanpath:$MANPATH"
        fi
    done
fi
