# # 補完
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ':completion:*' menu select
setopt CORRECT
# # ツールごとの補完
# ## stack
if [[ -x "stack" ]];then
    eval "$(stack --bash-completion-script stack)"
fi
# ## wp-completion.bash
if [[ -f ~/etc/wp-completion.bash ]];then
    source ~/etc/wp-completion.bash
fi
# ## GitHub CLI
if [[ -x "gh" ]];then
    eval "$(gh completion -s zsh)"
fi
