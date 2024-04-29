"Dvorak用
inoremap <silent> hh <ESC>

nnoremap h <Nop>
nnoremap j <Nop>
nnoremap k <Nop>
nnoremap l <Nop>
nnoremap t <Nop>
nnoremap s <Nop>

xnoremap h <Nop>
xnoremap j <Nop>
xnoremap k <Nop>
xnoremap l <Nop>
xnoremap t <Nop>
xnoremap s <Nop>

onoremap h <Nop>
onoremap j <Nop>
onoremap k <Nop>
onoremap l <Nop>
onoremap t <Nop>
onoremap s <Nop>

" Move
nnoremap d h
nnoremap h j
nnoremap t k
nnoremap n l

xnoremap d h
xnoremap h j
xnoremap t k
xnoremap n l

onoremap d h
onoremap h j
onoremap t k
onoremap n l

" fold-jump

nnoremap zh zj
nnoremap zt zk

xnoremap zh zj
xnoremap zt zk

onoremap zh zj
onoremap zt zk

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
