vim9script
# 検索
# 拡張正規表現をデフォルトに
nnoremap / /\v
# 大文字小文字を区別しない
set ignorecase
set smartcase
# 末尾まで行ったら先頭に戻る
set wrapscan
# インクリメンタル検索
set incsearch
# ハイライト表示
set hlsearch
# ESC-ESCでハイライト消去
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
