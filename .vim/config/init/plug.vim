"vim-plug
"Install
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
" 保存する場所をシングルクォート
    call plug#begin('~/.vim/plugged')
        "https://github.com/hogehoge/plugin を入れたければ
        "Plug 'hogehoge/plugin'
        Plug 'vim-jp/vimdoc-ja'
        Plug  'altercation/vim-colors-solarized',
"            \ { 'do': 'cp colors/* ~/.vim/colors/' }
        "Plug 'syusui-s/scrapbox-vim', { 'for': 'scrapbox' }
        Plug 'Yggdroot/indentLine'
    call plug#end()
filetype plugin on
