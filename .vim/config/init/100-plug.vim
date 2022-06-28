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
    Plug 'romainl/flattened'
    Plug 'lifepillar/vim-solarized8'
    Plug 'thinca/vim-quickrun'
    Plug 'prabirshrestha/vim-lsp'
"   Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'kana/vim-filetype-haskell'
    Plug 'purescript-contrib/purescript-vim'
    Plug 'Twinside/vim-haskellFold'
"    Plug 'Yggdroot/indentLine'
    Plug 'junegunn/vim-easy-align'
    Plug 'machakann/vim-highlightedyank'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'itchyny/lightline.vim'
    Plug 'mattn/vim-maketable'
call plug#end()
filetype plugin on
