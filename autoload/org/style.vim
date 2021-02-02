"======================================================================
"
" style.vim - 
"
" Created by skywind on 2019/12/19
" Last Modified: 2019/12/19 16:06:59
"
"======================================================================

"----------------------------------------------------------------------
" default border style: 1/ascii, 2/single, 3/double
"----------------------------------------------------------------------
if get(g:, 'org#style#border', 0)
    let g:org#style#border = get(g:, 'org#style#border', 5)
endif

let g:org#style#tip_head = '[tip]'

let g:org#style#preview_w = 85
let g:org#style#preview_h = 10
let g:org#style#preview_number = 1
let g:org#style#preview_bordercolor = '#00ff00'


