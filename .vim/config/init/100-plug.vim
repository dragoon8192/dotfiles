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
    Plug 'Twinside/vim-haskellFold'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/vim-easy-align'
    Plug 'kana/vim-filetype-haskell'
    Plug 'lifepillar/vim-solarized8'
    Plug 'machakann/vim-highlightedyank'
    Plug 'mattn/vim-maketable'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'purescript-contrib/purescript-vim'
    Plug 'romainl/flattened'
    Plug 'thinca/vim-quickrun'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'vim-jp/vimdoc-ja'
"   Plug 'Yggdroot/indentLine'
"   Plug 'mattn/vim-lsp-settings'
call plug#end()
filetype plugin on
