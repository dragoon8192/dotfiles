# # 補完
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
# zstyle ':completion:*' file-patterns '*(/)' '*(.)'
zstyle ':completion:*:descriptions' format '%B%d%b'
setopt CORRECT
# # ツールごとの補完
# ## stack
if command -v stack >/dev/null 2>&1;then
    autoload -Uz bashcompinit && bashcompinit
    eval "$(stack --bash-completion-script stack)"
    unfunction bashcompinit
fi
# ## GitHub CLI
if command -v gh >/dev/null 2>&1;then
    eval "$(gh completion -s zsh)"
fi
# ## npm
if command -v npm >/dev/null 2>&1;then
    autoload -Uz bashcompinit && bashcompinit
    eval "$(npm completion)"
    unfunction bashcompinit
fi
