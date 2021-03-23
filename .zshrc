PROMPT='%c %# '
bindkey -v
bindkey "jj" vi-cmd-mode

#履歴
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

paths_file="$HOME/.zsh_paths"
#上から優先したいので逆順に頭に追加
if [ -f $paths_file ] ;then
    for binpath in $(tac "$paths_file") ;do
        if [ -d "$binpath" ] ; then
            PATH="$binpath:$PATH"
        fi
    done
fi
#export DISPLAY=:0.0

#GIT
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{yellow}[!]'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}[+]'
zstyle ':vcs_info:*' formats '%F{green}%c%u[%b]%f'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT='$vcs_info_msg_0_' #ここでは展開しないままにすること
