##補完
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ':completion:*' menu select
setopt CORRECT
if [[ -x "stack" ]];then
    eval "$(stack --bash-completion-script stack)"
fi
if [[ -f "~/etc/wp-completion.bash" ]];then
    source "~/etc/wp-completion.bash"
fi
