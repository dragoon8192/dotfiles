#!/usr/bin/env zsh 

IGNORE_PATTERN="^\.(git|travis)"

echo "Create dotfile links..."
for dotfile in .??*; do
    [[ $dotfile =~ $IGNORE_PATTERN ]] && continue
    if [ -e "$HOME/$dotfile" ] ;then
        echo "Back up $HOME/$dotfile to $HOME/$dotfile~"
        mv "$HOME/$dotfile" "$HOME/$dotfile~"
    fi
    ln -sniv "$(pwd)/$dotfile" "$HOME/$dotfile"
done
echo "Success!!"
