let g:quickrun_config = {
            \   '_': {
            \       'outputter/buffer/opener' : 'botright 8new',
            \       'outputter/buffer/close_on_empty' : 1,
            \       'hook/time/enable' : 1
            \   },
            \   'rust': {
            \       'exec' : 'cargo run'
            \   }
            \}
