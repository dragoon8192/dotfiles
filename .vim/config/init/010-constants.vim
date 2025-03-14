vim9script

# 全角文字の幅
set ambiwidth=double

# 例外
setcellwidths([[0xe0a0, 0xe0a3, 1], [0xe0b0, 0xe0b3, 1]])

const g:nerdIcons = {
    'tri_r':       '',
    'tri_line_r':  '',
    'tri_l':       '',
    'tri_line_l':  '',
    'git':         '',
    'lock':        '',
    'cd':          '❖ ',
    'time':        '󱑁',
    'error':       '',
    'warning':     '',
    'information': '',
    'hint':        '󰛨',
    'action':      '',
    'exit':        '󰩈',
    'wait':        '',
    'robot':       '󰚩',
    'robot_off':   '󱚧',
    'haskell':     '󰲒',
    'javascript':  '󰌞',
    'purescript':  '',
    'python':      '',
    'rust':        '󱘗',
    'typescript':  '󰛦',
    'vim':         '',
    'bash':        '',
    'docker':       '󰡨',
}
