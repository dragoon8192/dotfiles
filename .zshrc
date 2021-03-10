PROMPT='%c %# '
bindkey -v

paths_file="$HOME/.zshrc-paths"
#上から優先したいので逆順に頭に追加
if [ -f $paths_file ] ;then
    for binpath in $(tac "$paths_file") ;do
        if [ -d "$binpath" ] ; then
            PATH="$binpath:$PATH"
        fi
    done
fi
#export DISPLAY=:0.0
