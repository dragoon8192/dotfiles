nnoremap [fugitive]  <Nop>
nmap <Leader>g [fugitive]
nnoremap <silent> [fugitive]s :Git<CR>
nnoremap <silent> [fugitive]w :Gwrite<CR>
nnoremap <silent> [fugitive]c :Git commit -v<CR>
nnoremap <silent> [fugitive]b :Git blame<CR>
nnoremap <silent> [fugitive]d :Git diff --staged<CR>
nnoremap <silent> [fugitive]l :Git log<CR>
nnoremap <silent> [fugitive]m :Git mergetool<CR>
