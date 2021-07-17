##PATH
paths_file="$HOME/.zsh_paths"
#上から優先したいので逆順に頭に追加
if [ -f $paths_file ] ;then
    for l_path in $(tac "$paths_file") ;do
        if [ -d "$l_path" ] ; then
            PATH="$l_path:$PATH"
        fi
    done
fi
##MANPATH
manpaths_file="$HOME/.zsh_manpaths"
if [ -f $manpaths_file ] ;then
    for l_manpath in $(tac "$manpaths_file") ;do
        if [ -d "$l_manpath" ] ; then
            MANPATH="$l_manpath:$MANPATH"
        fi
    done
fi
##INFOPATH
infopaths_file="$HOME/.zsh_infopaths"
if [ -f $infopaths_file ] ;then
    for l_infopath in $(tac "$infopaths_file") ;do
        if [ -d "$l_infopath" ] ; then
            INFOPATH="$l_infopath:$INFOPATH"
        fi
    done
fi
##LD_LIBRARY_PATH
ld_library_paths_file="$HOME/.zsh_ld_library_paths"
if [ -f $ld_library_paths_file ] ;then
    for l_ld_library_path in $(tac "$ld_library_paths_file") ;do
        if [ -d "$l_ld_library_path" ] ; then
            LD_LIBRARY_PATH="$l_ld_library_path:$LD_LIBRARY_PATH"
        fi
    done
fi
# 重複を削除
typeset -U PATH MANPATH INFOPATH LD_LIBRARY_PATH
