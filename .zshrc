for f in ~/.zsh/*.zsh ; do
    source $f
done
##OSによる分岐
for f in ~/.zsh-$(uname -s)-$(uname -n)/*.zsh ; do
    source $f
done
