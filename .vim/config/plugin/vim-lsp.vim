if executable('haskell-language-server-wrapper')
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'Haskell-LS',
        \ 'cmd': {server_info->['haskell-language-server-wrapper', '--lsp']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(
        \     lsp#utils#find_nearest_parent_file_directory(
        \         lsp#utils#get_buffer_path(),
        \         ['.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git'],
        \     ))},
        \ 'whitelist': ['haskell', 'lhaskell'],
        \ })
endif

if executable('vim-language-server')
  augroup LspVim
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'Vim-LS',
        \ 'cmd': {server_info->['vim-language-server', '--stdio']},
        \ 'whitelist': ['vim'],
        \ 'initialization_options': {
        \   'vimruntime': $VIMRUNTIME,
        \   'runtimepath': &rtp,
        \ }})
  augroup END
endif

if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
                \ 'name': 'TypeScript-LS',
                \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
                \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
                \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
                \ })
endif

if executable('purescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
                \ 'name': 'PureScript-LS',
                \ 'cmd': { server_info->[&shell, &shellcmdflag, 'purescript-language-server --stdio']},
                \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
                \ 'whitelist': ['purescript']
                \ })
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    map gl [vim-lsp]
    nmap <buffer> [vim-lsp]d <plug>(lsp-definition)
    nmap <buffer> [vim-lsp]s <plug>(lsp-document-symbol-search)
    nmap <buffer> [vim-lsp]S <plug>(lsp-workspace-symbol-search)
    nmap <buffer> [vim-lsp]r <plug>(lsp-references)
    nmap <buffer> [vim-lsp]i <plug>(lsp-implementation)
    nmap <buffer> [vim-lsp]t <plug>(lsp-type-definition)
    nmap <buffer> [vim-lsp]n <plug>(lsp-rename)
    nmap <buffer> [vim-lsp][ <plug>(lsp-previous-diagnostic)
    nmap <buffer> [vim-lsp]] <plug>(lsp-next-diagnostic)
    nmap <buffer> [vim-lsp]a <plug>(lsp-code-action)
    " nmap <buffer> gD <plug>(lsp-document-diagnostic)
    nmap <buffer> [vim-lsp]h <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " let g:lsp_diagnostics_echo_cursor = 1
    let g:lsp_diagnostics_float_cursor = 1
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
