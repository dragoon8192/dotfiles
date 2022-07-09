nnoremap [fugitive]  <Nop>
nmap <Leader>g [fugitive]
nnoremap <silent> [fugitive]s :Gstatus<CR><C-w>T
nnoremap <silent> [fugitive]w :Gwrite<CR>
nnoremap <silent> [fugitive]c :Git commit -v<CR>
nnoremap <silent> [fugitive]b :Gblame<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>
nnoremap <silent> [fugitive]m :Gmerge<CR>
