set wildmenu

"検索
"拡張正規表現をデフォルトに
    nnoremap / /\v
"大文字小文字を区別しない
    set ignorecase
    set smartcase
"末尾まで行ったら先頭に戻る
    set wrapscan
"インクリメンタル検索
    set incsearch
"ハイライト表示
    set hlsearch
"ESC-ESCでハイライト消去
    nnoremap <ESC><ESC> :nohlsearch<CR><ESC>

"入力
"jjでESC
    inoremap <silent> jj <ESC>
"Tabの表示幅
    set tabstop=4
"Tabで代わりにSpace
    set expandtab
"Tabで入力される個数
    set softtabstop=4
"インデント幅
    set shiftwidth=4
"改行時の自動インデント
    set smartindent
"クリップボード
    set clipboard=unnamed,autoselect

"表示
"構文ハイライト
    syntax on
"TAB, 行末スペースの表示
    set list
    set listchars=tab:^\ ,trail:~
"括弧の強調
    set showmatch
"タイトル表示
    set title
"行数表示
    set number
"全角文字の幅
    set ambiwidth=double
