"let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')
"let s:rtp = fnamemodify(s:home, ':h')

if get(g:, 'language_path', {}) == {}
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


"let s:fname = s:rtp . '/colors/org/default.vim'
""exec "source " . fnameescape(s:fname)

colorscheme s:fname
finish

