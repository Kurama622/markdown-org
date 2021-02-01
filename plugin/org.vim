let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go build -o tmp && ./tmp && rm tmp",
            \ "golang": "go build -o tmp && ./tmp && rm tmp",
            \ }

nnoremap <M-c> :call org#main#runCodeBlock()<CR>
