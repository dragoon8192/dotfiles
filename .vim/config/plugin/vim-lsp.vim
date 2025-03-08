vim9script
g:lsp_diagnostics_enabled = v:true
g:lsp_diagnostics_virtual_text_enabled = v:false
g:lsp_diagnostics_echo_cursor = v:false
g:lsp_diagnostics_float_cursor = v:true
g:lsp_diagnostics_float_insert_mode_enabled = v:false
g:lsp_diagnostics_float_delay = 200
g:lsp_signs_enabled = v:true
g:lsp_log_file = expand('~/vim-lsp.log')

g:lsp_diagnostics_signs_error = {'text': g:nerdIcons.error}
g:lsp_diagnostics_signs_warning = {'text': g:nerdIcons.warning}
g:lsp_diagnostics_signs_information = {'text': g:nerdIcons.information}
g:lsp_diagnostics_signs_hint = {'text': g:nerdIcons.hint}
g:lsp_document_code_action_signs_hint = {'text': g:nerdIcons.action}

def g:OnLspBufferEnabled()
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    setlocal foldmethod=expr
    setlocal foldexpr=lsp#ui#vim#folding#foldexpr()
    setlocal foldtext=lsp#ui#vim#folding#foldtext()
    if exists('+tagfunc')
        setlocal tagfunc=lsp#tagfunc
    endif
    map <Leader>l [vim-lsp]
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
    nnoremap <buffer> [vim-lsp]H <plug>(lsp-document-diagnostics)
    nnoremap <buffer> <Leader>h <plug>(lsp-hover)
    nnoremap <buffer> [vim-lsp]h <plug>(lsp-hover)
    inoremap <buffer> <expr>[vim-lsp]d lsp#scroll(+4)
    inoremap <buffer> <expr>[vim-lsp]h lsp#scroll(-4)
    g:lsp_format_sync_timeout = 1000
    autocmd BufWritePre *.rs,*.go LspDocumentFormatSync()
enddef

augroup LspInstall
    autocmd!
    autocmd User lsp_buffer_enabled g:OnLspBufferEnabled()
augroup END

# Vim9Script のバグっぽい動作のため、 `,` の後ろに1つスペースを付ける

# Vim
if executable('vim-language-server')
    augroup VimLS
        autocmd!
        autocmd User lsp_setup {
            lsp#register_server({
                name:      'VimLS', 
                icon:      g:nerdIcons.vim, 
                cmd:       ['vim-language-server', '--stdio'], 
                allowlist: ['vim'], 
                initialization_options: {
                    'vimruntime': $VIMRUNTIME, 
                    'runtimepath': &rtp, 
                \}
            \})
        }
    augroup END
endif

# Dockerfile
if executable('docker-langserver')
    augroup DockerLS
        autocmd!
        autocmd User lsp_setup {
            lsp#register_server({
                name: 'DockerLS', 
                icon: g:nerdIcons.docker, 
                cmd: ['docker-langserver', '--stdio'], 
                allowlist: ['dockerfile']
            \})
        }
    augroup END
endif

# Bash, Zsh, Sh
if executable('bash-language-server')
    augroup BashLS
        autocmd!
        autocmd User lsp_setup {
            lsp#register_server({
                name:      'BashLS', 
                icon:      g:nerdIcons.bash, 
                cmd:       ['bash-language-server'], 
                allowlist: ['sh', 'bash', 'zsh']
            \})
        }
    augroup END
endif

# Rust
if executable('rust-analyzer')
    augroup RustLS
        autocmd!
        autocmd User lsp_setup {
            lsp#register_server({
                name:      'RustLS', 
                icon:      g:nerdIcons.rust, 
                cmd:       ['rust-analyzer'], 
                allowlist: ['rust'], 
                initialization_options: {
                    cargo: {
                        buildScripts: {
                            enable: v:true, 
                        \}, 
                    \}, 
                    procMacro: {
                        enable: v:true
                    \}
                \}
            \})
        }
    augroup END
endif

# Haskell
if executable('haskell-language-server-wrapper')
    augroup HaskellLS
        autocmd!
        autocmd User lsp_setup {
            lsp#register_server({
                name:      'HaskellLS', 
                icon:      g:nerdIcons.haskell, 
                cmd:       ['haskell-language-server-wrapper', '--lsp'], 
                allowlist: ['haskell', 'lhaskell'], 
                root_uri:  (server_info) => lsp#utils#path_to_uri(
                    \       lsp#utils#find_nearest_parent_file_directory(
                    \           lsp#utils#get_buffer_path(),
                    \           ['.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml', '.git']
                    \       )
                    \)
            \})
        }
    augroup END
endif

# # JavaScript, TypeScript
# if executable('typescript-language-server')
#     augroup LspJavaScript
#         autocmd!
#         autocmd User lsp_setup call lsp#register_server({
#         \   'name':      'TypeScript-LS for JS',
#         \   'icon':      g:nerdIcons.javascript,
#         \   'cmd':       {
#         \       server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']
#         \   },
#         \   'allowlist': ['javascript', 'javascript.jsx', 'javascriptreact'],
#         \   'root_uri':  {
#         \       server_info->lsp#utils#path_to_uri(
#         \           lsp#utils#find_nearest_parent_file_directory(
#         \               lsp#utils#get_buffer_path(),
#         \               ['package.json'],
#         \           )
#         \       )
#         \   },
#         \ })
#     augroup END
#     augroup LspTypeScript
#         autocmd!
#         autocmd User lsp_setup call lsp#register_server({
#         \   'name':      'TypeScript-LS',
#         \   'icon':      g:nerdIcons.typescript,
#         \   'cmd':       {
#         \       server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']
#         \   },
#         \   'allowlist': ['typescript', 'typescript.tsx', 'typescriptreact'],
#         \   'root_uri':  {
#         \       server_info->lsp#utils#path_to_uri(
#         \           lsp#utils#find_nearest_parent_file_directory(
#         \               lsp#utils#get_buffer_path(),
#         \               ['tsconfig.json'],
#         \           )
#         \       )
#         \   },
#         \ })
#     augroup END
# endif

# # PureScript
# if executable('purescript-language-server')
#     augroup LspPureScript
#         autocmd!
#         autocmd User lsp_setup call lsp#register_server({
#         \   'name':      'PureScript-LS',
#         \   'icon':      g:nerdIcons.purescript,
#         \   'cmd':       {
#         \       server_info->['purescript-language-server', '--stdio']
#         \   },
#         \   'allowlist': ['purescript'],
#         \   'root_uri':  {
#         \       server_info->lsp#utils#path_to_uri(
#         \           lsp#utils#find_nearest_parent_file_directory(
#         \               lsp#utils#get_buffer_path(),
#         \               ['bower.json', 'psc-package.json', 'spago.dhall'],
#         \           )
#         \       )
#         \   },
#         \   'workspace_config': {
#         \       'purescript': {
#         \           'addSpagoSources': v:true,
#         \           'addNpmPath': v:true,
#         \           'formatter': 'pures-tidy',
#         \       }
#         \   },
#         \ })
#     augroup END
# endif

# # Python
# if executable('pylsp')
#     augroup LspPython
#         autocmd!
#         autocmd User lsp_setup call lsp#register_server({
#         \   'name':             'pylsp',
#         \   'icon':             g:nerdIcons.python,
#         \   'cmd':              {
#         \       server_info->['pylsp']
#         \   },
#         \   'allowlist':        ['python'],
#         \   'workspace_config': {
#         \       'pylsp': {
#         \           'plugins': {
#         \               'pylsp-mypy':{
#         \                   'enabled': v:true,
#         \                   'live_mode': v:true,
#         \                   'strict': v:false,
#         \               },
#         \           },
#         \       },
#         \   },
#         \ })
#     augroup END
# endif
