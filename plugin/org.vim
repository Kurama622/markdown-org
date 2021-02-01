let g:language_path = {
            \ "python":"python",
            \ "python3":"python",
            \ "go": "go build && ./" . expand('%<') . " && rm " . expand('%<')
            \ }

echo expand('%<')
nnoremap <M-c> :call org#main#runCodeBlock()<CR>
