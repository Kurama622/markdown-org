if get(g:, 'language_path', ' ')
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

nnoremap <C-Enter> :call org#main#runCodeBlock()<CR>


nnoremap <C-S-Enter> :call org#main#runLanguage()<CR>

finish

