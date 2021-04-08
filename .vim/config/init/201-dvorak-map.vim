"Dvorak用
inoremap <silent> hh <ESC>

noremap t <Nop>
noremap s <Nop>

noremap d h
noremap h j
noremap t k
noremap n l

noremap k d
noremap s n

noremap T <Nop>
noremap S <Nop>

noremap K D
noremap gK K
noremap S N

"for netrw
augroup dragoon8192-Dvorak
    autocmd!
    autocmd FileType netrw nnoremap <buffer> t k
augroup END
