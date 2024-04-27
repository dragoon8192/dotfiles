" Remove original keybindings.
silent! nunmap gc
silent! nunmap gcc
silent! xunmap gc
silent! ounmap gc

noremap [vim-commentary] <Nop>
map <Leader>c [vim-commentary]
nmap [vim-commentary] <Plug>Commentary
nmap [vim-commentary]c <Plug>CommentaryLine
xmap [vim-commentary] <Plug>Commentary
omap [vim-commentary] <Plug>Commentary
