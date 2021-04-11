export LANG='ja_JP.UTF-8'
#VIM操作用
bindkey -v
#bindkey "jj" vi-cmd-mode
#for Dvorak
bindkey -v "hh" vi-cmd-mode
#vi-cmd
bindkey -a "K" vi-kill-eol
bindkey -a "S" vi-rev-repeat-search
bindkey -a "d" vi-backward-char
bindkey -a "h" down-line-or-history
bindkey -a "t" up-line-or-history
bindkey -a "n" vi-forward-char
bindkey -a "k" vi-delete
bindkey -a "s" vi-repeat-search

##ALIAS
alias ghc='stack ghc'

##PROMPT
#colors
# Solarized ANSI
    #    0: base03   1: red      2: green    3: yellow
    #    4: blue     5: magenta  6: cyan     7: base3
    #    8: base02   9: orange  10: base01  11: base00
    #   12: base0   13: violet  14: base1   15: base2
local f_cd=15
local k_cd=6
#text
typeset c_tri_r='' c_tri_l='' c_git='' c_cd='❖ '
# Associative array
typeset -i size_aa=8
typeset -A aa_nor=([fc]=15 [kc]=9 [str]='操作' [dir]='r')
typeset -A aa_ins=([fc]=15 [kc]=6 [str]='入力' [dir]='r')
typeset -A aa_cd=([fc]=15 [kc]=6 [str]="$c_cd%c" [dir]='l')
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

function z_prompt {
    [[ $# == 0 ]] && return
    case $1 in
        '-^')  # begin fc
            typeset -A ass
            set -A ass ${@:2:$size_aa}
            z_prompt -K $ass[kc] ${@:2}
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
            echo "%S$c_tri_r%s%k"
            return 0
            ;;
        '-L')  # end
            echo "$c_tri_l%k"
            return 0
            ;;
        *)  # Associative array
            typeset -A ass
            set -A ass ${@:1:$size_aa}
            case $ass[dir] in
                r)
                    echo -n "%F{$ass[kc]}%S$c_tri_r%s"
                    echo -n "%F{$ass[fc]}%K{$ass[kc]}$ass[str]%f"
                    ;;
                l)
                    echo -n "%F{$ass[kc]}$c_tri_l"
                    echo -n "%F{$ass[fc]}%K{$ass[kc]}$ass[str]%f"
                    ;;
            esac
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
zstyle ':vcs_info:git:*' unstagedstr '%F{red}[+]'   # %u
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}[!]'  # %c
zstyle ':vcs_info:*' formats '%F{cyan}%c%u[%b:%r]%f'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$(z_prompt\
    ${(kv)aa_cd}
)$vcs_info_msg_0_


##補完
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ':completion:*' menu select
setopt CORRECT
eval "$(stack --bash-completion-script stack)"

##履歴
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt EXTENDED_HISTORY

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

##色設定
#lsの色
eval `dircolors ~/etc/dircolors-solarized/dircolors.ansi-light`
alias ls='ls --color=auto'

##OSによる分岐
case ${OSTYPE} in
    darwin*)
        source ~/.zshrc.darwin
        ;;
    linux*)
        source ~/.zshrc.linux
        ;;
esac
