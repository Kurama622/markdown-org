let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go run",
            \ "golang": "go run",
            \ }

nnoremap <M-c> :call org#main#runCodeBlock()<CR>
