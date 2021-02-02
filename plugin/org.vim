let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go",
            \ "c": "gcc",
            \ "cpp": "g++",
            \ "javascript": "node",
            \ }

nnoremap <M-c> :call org#main#runCodeBlock()<CR>

finish

