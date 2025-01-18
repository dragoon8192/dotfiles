function export_paths {
    for target in "$@"; do
        file="${HOME}/.zsh_local_paths/${target}"
        #上から優先したいので逆順に頭に追加
        if [[  -f "${file}" ]] ;then
            while IFS= read -r line || [[  -n "${line}" ]] ;do
                line=$(echo "${line}")
                if [[  -d "${line}" ]] ; then
                    export "${target}=${line}:${(P)target}"
                fi
            done < <(/usr/bin/tac "${file}")
        else
            echo "Warning: Path file not found - ${file}" >&2
        fi
        # 重複を削除
        typeset -U "$target"
    done
}

export_paths PATH MANPATH INFOPATH LIBRARY_PATH LD_LIBRARY_PATH

[ -f "/home/dragoon8192/.ghcup/env" ] && . "/home/dragoon8192/.ghcup/env" # ghcup-env
