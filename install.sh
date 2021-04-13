#!/usr/bin/env zsh 

IGNORE_PATTERN="^\.(git|travis)"
DIR_ONLY_CONTENTS=".vim"

echo "Create dotfile links..."

for dotfile in .??*; do
    [[ $dotfile =~ $IGNORE_PATTERN ]] && continue
    if [[ $dotfile = $DIR_ONLY_CONTENTS ]] && continue
    if [[ -e "$HOME/$dotfile" && ! -L "$HOME/$dotfile" ]] ;then
        echo "Back up $HOME/$dotfile to $HOME/$dotfile~"
        mv "$HOME/$dotfile" "$HOME/$dotfile~"
    fi
    ln -sniv "$(pwd)/$dotfile" "$HOME/$dotfile"
done

for dir in $DIR_ONLY_CONTENTS; do
    mkdir -p "$HOME/$dir"
    for content in "$dir"/*; do
        if [[ -e "$HOME/$content" && ! -L "$HOME/$content" ]] ;then
            echo "Back up $HOME/$content to $HOME/$content~"
            mv "$HOME/$content" "$HOME/$content~"
        fi
        ln -sniv "$(pwd)/$content" "$HOME/$content"
    done
done

echo "Success!!"
