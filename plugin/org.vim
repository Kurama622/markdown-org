let g:language_path = {
            \ 'python':'python',
            \ 'python3':'python',
            \ 'go': 'go build && ./' . expand('%<') . ' && rm ' . expand('%<')
            \ }

"echo g:language_path['go']
nnoremap <M-c> :call org#main#runCodeBlock()<CR>
