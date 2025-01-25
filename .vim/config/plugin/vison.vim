vim9script

# バッファの basename が schema 名と同じなら`:Vison`の引数を省略
# autocmd BufRead,BufNewFile package.json Vison

# バッファの basename が schema 名と違うときは引数を追加
# autocmd BufRead,BufNewFile .bowerrc Vison bowerrc.json
