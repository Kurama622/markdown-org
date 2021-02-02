let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go build -o tmp && ./tmp && rm tmp",
            \ "c": "gcc " . expand('%') . " -Wall -o " . expand('%<'),
            \ }

nnoremap <M-c> :call org#main#runCodeBlock()<CR>
