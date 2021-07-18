##PATH
paths_file="$HOME/.zsh_paths"
#上から優先したいので逆順に頭に追加
if [ -f $paths_file ] ;then
    for l_path in $(tac "$paths_file") ;do
        if [ -d "$l_path" ] ; then
            export PATH="$l_path:$PATH"
        fi
    done
fi
##MANPATH
manpaths_file="$HOME/.zsh_manpaths"
if [ -f $manpaths_file ] ;then
    while read line ;do
        line=$(eval echo $line)
        if [ -d "$line" ] ; then
            export MANPATH="$line:$MANPATH"
        fi
    done < <(tac "$manpaths_file")
fi
##INFOPATH
infopaths_file="$HOME/.zsh_infopaths"
if [ -f $infopaths_file ] ;then
    while read line ;do
        line=$(eval echo $line)
        if [ -d "$line" ] ; then
            export INFOPATH="$line:$INFOPATH"
        fi
    done < <(tac "$infopaths_file")
fi
##LD_LIBRARY_PATH
ld_library_paths_file="$HOME/.zsh_ld_library_paths"
if [ -f $ld_library_paths_file ] ;then
    while read line ;do
        line=$(eval echo $line)
        if [ -d "$line" ] ; then
            export LD_LIBRARY_PATH="$line:$LD_LIBRARY_PATH"
        fi
    done < <(tac "$ld_library_paths_file")
fi
# 重複を削除
typeset -U PATH MANPATH INFOPATH LD_LIBRARY_PATH
