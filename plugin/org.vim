if get(g:, 'language_path', ' ') == ' '
    let g:language_path = {
                \ "python":"python",
                \ "python3":"python3",
                \ "go": "go",
                \ "c": "gcc",
                \ "cpp": "g++",
                \ "c++": "g++",
                \ "javascript": "node",
                \ }
endif

nnoremap <leader>c :call org#main#runCodeBlock()<CR>

nnoremap <leader>C :call org#main#runLanguage()<CR>

finish

