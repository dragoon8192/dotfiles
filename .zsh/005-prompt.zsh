##PROMPT
#colors
# Solarized ANSI
    #    0: base03   1: red      2: green    3: yellow
    #    4: blue     5: magenta  6: cyan     7: base3
    #    8: base02   9: orange  10: base01  11: base00
    #   12: base0   13: violet  14: base1   15: base2
#text
typeset c_tri_r='' c_tri_l='' c_git='g:' c_cd='#'
# Associative array
typeset -i size_aa=8
typeset -A aa_nor=([fc]=15 [kc]=9 [str]='操作' [dir]='r')
typeset -A aa_ins=([fc]=15 [kc]=6 [str]='入力' [dir]='r')
if [[ -n "${REMOTEHOST}${SSH_CONNECTION}" ]];then
    typeset -A aa_ssh=([fc]=15 [kc]=3 [str]='遠隔' [dir]='r')
else
    typeset -A aa_ssh=()
fi
if [[ $UID == 0 ]];then
    typeset -A aa_root=([fc]=15 [kc]=10 [str]='管理者' [dir]='r')
else
    typeset -A aa_root=()
fi
typeset -A aa_cd=([fc]=15 [kc]=6 [str]="$c_cd%c" [dir]='l')
typeset -A aa_git_b=([fc]=15 [kc]=6 [str]="$c_git%b" [dir]='r')
typeset -A aa_git_stg=([fc]=15 [kc]=3 [str]="!" [dir]='r')
typeset -A aa_git_ustg=([fc]=15 [kc]=9 [str]="+" [dir]='r')
typeset -A aa_git_act=([fc]=15 [kc]=9 [str]="%a" [dir]='r')

function z_prompt {
    [[ $# == 0 ]] && return
    case $1 in
        '-^')  # begin fc
            typeset -A ass
            set -A ass ${@:2:$size_aa}
            echo -n "%K{$ass[kc]}"
            z_prompt ${@:2}
            ;;
        '-K')
            echo -n "%K{$2}"
            z_prompt ${@:3}
            ;;
        '-F')
            echo -n "%F{$2}"
            z_prompt ${@:3}
            ;;
        '-R')  # end
            echo "%k$c_tri_r%f"
            return 0
            ;;
        '-L')  # end
            echo "%k%S$c_tri_l%s%f"
            return 0
            ;;
        '-$')  # end
            echo "%k%f"
            return 0
            ;;
        *)  # Associative array
            typeset -A ass
            set -A ass ${@:1:$size_aa}
            case $ass[dir] in
                r)
                    echo -n "%F{$ass[kc]}%S$c_tri_r%s"
                    ;;
                l)
                    echo -n "%F{$ass[kc]}$c_tri_l"
                    ;;
            esac
            echo -n "%F{$ass[fc]}%K{$ass[kc]}$ass[str]%f%k"
            echo -n "%F{$ass[kc]}%K{$ass[kc]}"
            shift $size_aa
            z_prompt $@
    esac
}

function zle-line-init zle-keymap-select {
    local -A aa_mode
    case $KEYMAP in
        vicmd)
            set -A aa_mode ${(kv)aa_nor}
            ;;
        main|viins)
            set -A aa_mode ${(kv)aa_ins}
            ;;
    esac
    PROMPT=$(z_prompt\
        -^ ${(kv)aa_root} ${(kv)aa_ssh} ${(kv)aa_mode} -R\
    )
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

##GIT RPROMPT
autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr "${(kv)aa_git_ustg} "   # %u
zstyle ':vcs_info:git:*' stagedstr "${(kv)aa_git_stg} "  # %c
zstyle ':vcs_info:*' formats "%u%c${(kv)aa_git_b}"
zstyle ':vcs_info:*' actionformats "%u%c${(kv)aa_git_b} ${(kv)aa_git_act}"
precmd () { vcs_info }
RPROMPT='$(z_prompt ${(kv)aa_cd} $(echo $vcs_info_msg_0_) -$)'
