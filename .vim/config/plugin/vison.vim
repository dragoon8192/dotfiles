vim9script
augroup vison_setting
    autocmd!
    # バッファの basename が schema 名と同じなら`:Vison`の引数を省略
    autocmd BufRead,BufNewFile package.json Vison
    autocmd BufRead,BufNewFile appsscript.json Vison
    # バッファの basename が schema 名と違うときは引数を追加
    autocmd BufRead,BufNewFile .clasp.json Vison clasp.json
augroup END

