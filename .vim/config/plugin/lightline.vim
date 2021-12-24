set laststatus=2
set noshowmode
let g:lightline = {
    \   'colorscheme': 'solarized',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'readonly', 'gitbranch', 'filename', 'modified' ] ],
    \       'right':[ [ 'lineinfo' ],
    \                 [ 'percent' ],
    \                 [ 'fileformat', 'fileencoding', 'filetype' ] ] },
    \   'inactive': {
    \       'left': [ [ 'filename' ] ],
    \       'right':[ [ 'lineinfo' ],
    \                 [ 'percent' ] ] },
    \   'tabline': {
    \       'left': [ [ 'tabs' ] ],
    \       'right':[ [ 'close' ] ] },
    \   'component_function': {
    \       'gitbranch': 'LightlineFugitive'},
    \ }

function! LightlineFugitive()
    if &filetype !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        return fugitive#head()
    else
        return ''
    endif
endfunction
