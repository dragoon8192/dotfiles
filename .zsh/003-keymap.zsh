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
