PROMPT='%c %# '
bindkey -v

for binpath in "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" "/usr/bin" "/usr/local/bin" "$HOME/.local/bin" "$HOME/bin"
do
    if [ -d "$binpath" ] ; then
        addpath="$addpath:$binpath"
    fi
done
export PATH="$addpath:$PATH"
#export DISPLAY=:0.0
