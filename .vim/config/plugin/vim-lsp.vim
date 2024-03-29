let g:lsp_diagnostics_enabled = v:true
let g:lsp_diagnostics_virtual_text_enabled = v:false
let g:lsp_diagnostics_echo_cursor = v:false
let g:lsp_diagnostics_float_cursor = v:true
let g:lsp_diagnostics_float_delay = 200
let g:lsp_signs_enabled = v:true
" signs
let g:lsp_diagnostics_signs_error = {'text': g:nerdIcons.error}
let g:lsp_diagnostics_signs_warning = {'text': g:nerdIcons.warning}
let g:lsp_diagnostics_signs_information = {'text': g:nerdIcons.information}
let g:lsp_diagnostics_signs_hint = {'text': g:nerdIcons.hint}
let g:lsp_document_code_action_signs_hint = {'text': g:nerdIcons.action}

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    " mapping
    map gl [vim-lsp]
    nnoremap <buffer> [vim-lsp]D <plug>(lsp-definition)
    nnoremap <buffer> [vim-lsp]d <plug>(lsp-peek-definition)
    nnoremap <buffer> [vim-lsp]s <plug>(lsp-document-symbol-search)
    nnoremap <buffer> [vim-lsp]S <plug>(lsp-workspace-symbol-search)
    nnoremap <buffer> [vim-lsp]r <plug>(lsp-references)
    nnoremap <buffer> [vim-lsp]i <plug>(lsp-implementation)
    nnoremap <buffer> [vim-lsp]t <plug>(lsp-type-definition)
    nnoremap <buffer> [vim-lsp]n <plug>(lsp-rename)
    nnoremap <buffer> [vim-lsp][ <plug>(lsp-previous-diagnostic)
    nnoremap <buffer> [vim-lsp]] <plug>(lsp-next-diagnostic)
    nnoremap <buffer> [vim-lsp]a <plug>(lsp-code-action)
    " nnoremap <buffer> gD <plug>(lsp-document-diagnostic)
    nnoremap <buffer> <Leader>h <plug>(lsp-hover)
    nnoremap <buffer> [vim-lsp]h <plug>(lsp-hover)
    inoremap <buffer> <expr>[vim-lsp]d lsp#scroll(+4)
    inoremap <buffer> <expr>[vim-lsp]h lsp#scroll(-4)
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    autocmd!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Rust
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'icon': g:nerdIcons.rust,
        \   'cmd': {server_info->['rust-analyzer']},
        \   'allowlist': ['rust'],
        \   'initialization_options': {
        \     'cargo': {
        \       'buildScripts': {
        \         'enable': v:true,
        \       },
        \     },
        \     'procMacro': {
        \       'enable': v:true,
        \     },
        \   },
        \ })
endif

" Haskell
if executable('haskell-language-server-wrapper')
    augroup LspHaskell
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'Haskell-LS',
        \   'icon': g:nerdIcons.haskell,
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

" Vim
if executable('vim-language-server')
    augroup LspVim
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'Vim-LS',
        \   'icon': g:nerdIcons.vim,
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

" JavaScript, TypeScript
if executable('typescript-language-server')
    augroup LspJavaScript
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'TypeScript-LS for JS',
        \   'icon': g:nerdIcons.javascript,
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

" PureScript
if executable('purescript-language-server')
    augroup LspPureScript
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'PureScript-LS',
        \   'icon': g:nerdIcons.purescript,
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
        \       'purescript': {
        \           'addSpagoSources': v:true,
        \           'addNpmPath': v:true,
        \           'formatter': 'pures-tidy',
        \       }
        \   },
        \ })
    augroup END
endif

" Python
if executable('pylsp')
    augroup LspPython
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \   'name': 'pylsp',
        \   'icon': g:nerdIcons.python,
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
