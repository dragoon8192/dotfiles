for f in ~/.zsh/*.zsh ; do
    source $f
done
##OSによる分岐
case ${OSTYPE} in
    darwin*)
        source ~/.zsh/zshrc.darwin
        ;;
    linux*)
        source ~/.zsh/zshrc.linux
        ;;
esac
