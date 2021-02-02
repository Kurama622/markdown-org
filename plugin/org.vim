let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go build",
            \ "c": "gcc",
            \ }

nnoremap <M-c> :call org#main#runCodeBlock()<CR>

finish

"\ "go": "go build %<.go -o tmp && ./tmp && rm tmp",
