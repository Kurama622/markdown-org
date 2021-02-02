let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go build -o tmp && ./tmp && rm tmp",
            \ "c": "gcc " . expand('%<') . ".c -Wall -o " . expand('%<') . " && ./" . expand('%<') . " && rm " . expand('%<'),
            \ }

echo expand('%<')
nnoremap <M-c> :call org#main#runCodeBlock()<CR>
