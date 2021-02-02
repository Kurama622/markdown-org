let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go build -o tmp && ./tmp && rm tmp",
            \ "c": "gcc",
            \ }

nnoremap <M-c> :call org#main#runCodeBlock()<CR>
