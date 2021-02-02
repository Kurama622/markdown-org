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

if get(g:, 'default_quick_keys', 1)
    nnoremap <leader>c :call org#main#runCodeBlock()<CR>
    nnoremap <leader>C :call org#main#runLanguage()<CR>
endif

finish

