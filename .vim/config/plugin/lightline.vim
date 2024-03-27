set laststatus=2
set noshowmode
let g:lightline = {
    \   'colorscheme': 'solarized',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'readonly', 'gitbranch', 'filename', 'modified' ] ],
    \       'right':[ [ 'lineinfo', 'datetime' ],
    \                 [ 'percent' ],
    \                 [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \   },
    \   'inactive': {
    \       'left': [ [ 'filename' ] ],
    \       'right':[ [ 'lineinfo' ],
    \                 [ 'percent' ] ]
    \   },
    \   'tabline': {
    \       'left': [ [ 'tabs' ] ],
    \       'right':[ [ 'close' ] ]
    \   },
    \   'component': {
    \       'mode': '%{lightline#mode()}',
    \       'absolutepath': '%F',
    \       'relativepath': '%f',
    \       'modified': '%M',
    \       'bufnum': '%n',
    \       'paste': '%{&paste?"PASTE":""}',
    \       'readonly': '%R',
    \       'charvalue': '%b',
    \       'charvaluehex': '%04B',
    \       'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
    \       'fileformat': '%{&ff}',
    \       'filetype': '%{&ft!=#""?&ft:"no ft"}',
    \       'percent': '%3p%%',
    \       'percentwin': '%P',
    \       'spell': '%{&spell?&spelllang:""}',
    \       'lineinfo': '%3l:%-2c',
    \       'line': '%l',
    \       'column': '%c',
    \       'close': '%999X X ',
    \       'winnr': '%{winnr()}' },
    \   'component_function': {
    \       'gitbranch': 'LightlineGitbranch',
    \       'filename': 'LightlineFilename',
    \       'datetime': 'LightlineDateTime',
    \   },
    \   'separator': {
    \       'left': g:powerlineChars.tri_r,
    \       'right':g:powerlineChars.tri_l,
    \   },
    \   'subseparator': {
    \       'left': g:powerlineChars.tri_line_r,
    \       'right':g:powerlineChars.tri_line_l,
    \   },
    \ }

"let g:lightline.subseparator.left = g:powerlineChars.tri_line_r
"let g:lightline.subseparator.right = g:powerlineChars.tri_line_l

function! LightlineGitbranch()
    if &filetype !~? 'vimfiler\|gundo' && exists('*FugitiveHead') && FugitiveHead() != ''
        return g:powerlineChars.git . FugitiveHead()
    else
        return ''
    endif
endfunction

function! LightlineFilename()
    return g:powerlineChars.cd . expand('%:t')
endfunction

function! LightlineDateTime()
    return g:powerlineChars.time . system('echo -n `date "+%H:%M"`')
endfunction
