"vim-plug
"Install
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"保存する場所をシングルクォート
"https://github.com/hogehoge/plugin を入れたければ Plug 'hogehoge/plugin'
call plug#begin('~/.vim/plugged')
    Plug 'vim-jp/vimdoc-ja'
    Plug 'altercation/vim-colors-solarized'
    Plug 'prabirshrestha/vim-lsp'
    "Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    "Plug 'syusui-s/scrapbox-vim', { 'for': 'scrapbox' }
    Plug 'Yggdroot/indentLine'
call plug#end()
filetype plugin on
