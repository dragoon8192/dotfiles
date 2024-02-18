let g:quickrun_config = {
            \   '_': {
            \       'runner'                            : 'vimproc',
            \       'runner/vimproc/updatetime'         : 60,
            \       'outputter'                         : 'error',
            \       'outputter/error/success'           : 'buffer',
            \       'outputter/error/error'             : 'quickfix',
            \       'outputter/buffer/opener'           : 'botright 8new',
            \       'outputter/buffer/close_on_empty'   : 1,
            \       'hook/time/enable'                  : 1,
            \   },
            \   'rust': {
            \       'exec'                              : 'cargo run %o %a',
            \       'cmdopt'                            : '--message-format json-diagnostic-rendered-ansi',
            \   }
            \}
