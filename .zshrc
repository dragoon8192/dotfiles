#VIM操作用
bindkey -v
bindkey "jj" vi-cmd-mode

##PROMPT
#vim modeによる
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
            VIM_PROMPT='%F{red}-NOR-%f'
            ;;
        main|viins)
            VIM_PROMPT='%F{cyan}<INS>%f'
            ;;
    esac
    PROMPT=$VIM_PROMPT'%# '
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

##GIT RPROMPT
autoload -Uz vcs_info
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}[!]'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}[+]'
zstyle ':vcs_info:*' formats '%F{cyan}%c%u[%b]%f'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
#ここでは展開しないままにすること
GIT_PROMPT='$vcs_info_msg_0_'
RPROMPT='[%c]'$GIT_PROMPT


##補完
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
setopt CORRECT

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
