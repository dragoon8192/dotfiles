set laststatus=2
set noshowmode
let g:lightline = {
    \   'colorscheme': 'solarized',
    \   'active': {
    \       'left': [ [ 'mode', 'paste' ],
    \                 [ 'readonly', 'gitbranch', 'filename', 'modified' ] ],
    \       'right':[ [ 'lineinfo', 'datetime' ],
    \                 [ 'percent' ],
    \                 [ 'filetype', 'lsp_status'] ]
    \   },
    \   'inactive': {
    \       'left': [ [ 'filename' ] ],
    \       'right':[ [ 'lineinfo' ],
    \                 [ 'percent' ],
    \                 [ 'fileformat', 'fileencoding', 'filetype' ] ]
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
    \       'lsp_diagnostics': 'LightlineLspDiagnotstic',
    \       'lsp_status': 'LightlineLspStatus',
    \   },
    \   'separator': {
    \       'left': g:nerdIcons.tri_r,
    \       'right':g:nerdIcons.tri_l,
    \   },
    \   'subseparator': {
    \       'left': g:nerdIcons.tri_line_r,
    \       'right':g:nerdIcons.tri_line_l,
    \   },
    \ }

function! LightlineGitbranch() abort
    if &filetype !~? 'vimfiler\|gundo' && exists('*FugitiveHead') && FugitiveHead() != ''
        return g:nerdIcons.git . FugitiveHead()
    else
        return ''
    endif
endfunction

function! LightlineFilename() abort
    return g:nerdIcons.cd . expand('%:t')
endfunction

function! LightlineDateTime() abort
    return g:nerdIcons.time .  strftime('%H:%M:%S')
endfunction

call timer_start(1000, {-> execute('call lightline#update()')}, { 'repeat' : -1 })

" with vim-lsp

augroup LightlineOnLSP
    autocmd!
    autocmd User lsp_diagnostics_updated call lightline#update()
augroup END

function! s:get_allowed_servers_on_current_buf() abort
    let l:buf = bufnr('%')
    if getbufvar(l:buf, '&buftype') ==# 'terminal'
        return []
    else
        return lsp#get_allowed_servers(l:buf)
    endif
endfunction

function! s:lsp_server_status_to_icon(str) abort
    if a:str ==# 'exited'
        return g:nerdIcons.exit
    elseif a:str ==# 'starting'
        return g:nerdIcons.wait
    elseif a:str ==# 'running'
        return g:nerdIcons.robot
    elseif a:str ==# 'not running'
        return g:nerdIcons.robot_off
    else
        return g:nerdIcons.error
    endif
endfunction

function! s:get_lsp_server_icon(server_name) abort
    return lsp#get_server_info(a:server_name).icon
endfunction

function! LightlineLspStatus() abort
    let l:diag_counts = lsp#get_buffer_diagnostics_counts()
    if (l:diag_counts.error + l:diag_counts.warning) == 0
        let l:servers = s:get_allowed_servers_on_current_buf()
        let l:status =  map(l:servers, {i, s -> s:get_lsp_server_icon(s) . '' . s:lsp_server_status_to_icon(lsp#get_server_status(s))})
        return lightline#concatenate(l:status, v:true)
    else
        let l:errorStr = l:diag_counts.error == 0 ? '' : g:nerdIcons.error . printf('%d', l:diag_counts.error)
        let l:warningStr = l:diag_counts.warning == 0 ? '' : g:nerdIcons.warning . printf('%d', l:diag_counts.warning)
        return lightline#concatenate([l:errorStr, l:warningStr], v:true)
    endif
endfunction

function! LightlineLspDiagnotstic() abort
    let l:counts = lsp#get_buffer_diagnostics_counts()
    let l:errorStr = l:counts.error == 0 ? '' : g:nerdIcons.error . printf('%d', l:counts.error)
    let l:warningStr = l:counts.warning == 0 ? '' : g:nerdIcons.warning . printf('%d', l:counts.warning)
    return (l:counts.error + l:counts.warning) == 0 ? 'OK' : l:errorStr . l:warningStr
endfunction

