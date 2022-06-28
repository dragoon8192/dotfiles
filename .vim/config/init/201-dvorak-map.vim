"Dvorak用
inoremap <silent> hh <ESC>

noremap h <Nop>
noremap j <Nop>
noremap k <Nop>
noremap l <Nop>

noremap t <Nop>
noremap s <Nop>

" Move
noremap d h
noremap h j
noremap t k
noremap n l

" Delete
noremap k d
" next
noremap s n

noremap T <Nop>
noremap S <Nop>

noremap K D
noremap gK K
noremap S N

" window
noremap <C-W>h <Nop>
noremap <C-W>j <Nop>
noremap <C-W>k <Nop>
noremap <C-W>l <Nop>

noremap <C-W><C-H> <Nop>
noremap <C-W><C-J> <Nop>
noremap <C-W><C-K> <Nop>
noremap <C-W><C-L> <Nop>

noremap <C-W>d <C-W>h
noremap <C-W>h <C-W>j
noremap <C-W>t <C-W>k
noremap <C-W>n <C-W>l

noremap <C-W><C-D> <C-W><C-H>
noremap <C-W><C-H> <C-W><C-J>
noremap <C-W><C-T> <C-W><C-K>
noremap <C-W><C-N> <C-W><C-L>

"for netrw
augroup dragoon8192-Dvorak
    autocmd!
    autocmd FileType netrw nnoremap <buffer> t k
augroup END
