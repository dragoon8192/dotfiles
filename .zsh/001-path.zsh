function export_paths {
    for target in "$@"; do
        file="${HOME}/.zsh_local_paths/${target}"
        #上から優先したいので逆順に頭に追加
        if [ -f ${file} ] ;then
            while read line ;do
                line=$(eval echo ${line})
                if [ -d "${line}" ] ; then
                    export "${target}=${line}:${(P)target}"
                fi
            done < <(/usr/bin/tac "${file}")
        fi
        # 重複を削除
        typeset -U "$target"
    done
}

export_paths PATH MANPATH INFOPATH LIBRARY_PATH LD_LIBRARY_PATH
