if executable('haskell-language-server-wrapper')
    augroup LspHaskell
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'Haskell-LS',
        \   'cmd': {
        \       server_info->['haskell-language-server-wrapper', '--lsp']
        \   },
        \   'allowlist': ['haskell', 'lhaskell'],
        \   'root_uri': {
        \       server_info->lsp#utils#path_to_uri(
        \           lsp#utils#find_nearest_parent_file_directory(
        \               lsp#utils#get_buffer_path(),
        \               ['.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git'],
        \           )
        \       )
        \   },
        \ })
    augroup END
endif

if executable('vim-language-server')
    augroup LspVim
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'Vim-LS',
        \   'cmd': {
        \       server_info->['vim-language-server', '--stdio']
        \   },
        \   'allowlist': ['vim'],
        \   'initialization_options': {
        \       'vimruntime': $VIMRUNTIME,
        \       'runtimepath': &rtp,
        \   },
        \ })
    augroup END
endif

if executable('typescript-language-server')
    augroup LspJavaScript
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'TypeScript-LS for JS',
        \   'cmd': {
        \       server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']
        \   },
        \   'allowlist': ['javascript', 'javascript.jsx', 'javascriptreact'],
        \   'root_uri': {
        \       server_info->lsp#utils#path_to_uri(
        \           lsp#utils#find_nearest_parent_file_directory(
        \               lsp#utils#get_buffer_path(),
        \               ['package.json'],
        \           )
        \       )
        \   },
        \ })
    augroup END
endif

if executable('purescript-language-server')
    augroup LspPureScript
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'PureScript-LS',
        \   'cmd': {
        \       server_info->['purescript-language-server', '--stdio']
        \   },
        \   'allowlist': ['purescript'],
        \   'root_uri': {
        \       server_info->lsp#utils#path_to_uri(
        \           lsp#utils#find_nearest_parent_file_directory(
        \               lsp#utils#get_buffer_path(),
        \               ['bower.json', 'psc-package.json', 'spago.dhall'],
        \           )
        \       )
        \   },
        \   'workspace_config': {
        \       'purescript-language-server': {
        \           'addSpagoSources': v:true,
        \           'addNpmPath': v:true,
        \       }
        \   },
        \ })
    augroup END
endif

if executable('pylsp')
    augroup LspPython
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'pylsp',
        \   'cmd': {
        \       server_info->['pylsp']
        \   },
        \   'allowlist': ['python'],
        \   'workspace_config': {
        \       'pylsp': {
        \           'plugins': {
        \               'pylsp-mypy':{
        \                   'enabled': v:true,
        \                   'live_mode': v:true,
        \                   'strict': v:false,
        \               },
        \           },
        \       },
        \   },
        \ })
    augroup END
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    " mapping
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
    nmap <buffer> <Leader>h <plug>(lsp-hover)
    nmap <buffer> [vim-lsp]h <plug>(lsp-hover)
    inoremap <buffer> <expr>[vim-lsp]d lsp#scroll(+4)
    inoremap <buffer> <expr>[vim-lsp]h lsp#scroll(-4)

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
