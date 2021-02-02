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



"hi! link QuickBG QuickDefaultBackground
"hi! link QuickSel QuickDefaultSel
"hi! link QuickKey QuickDefaultKey
"hi! link QuickOff QuickDefaultDisable
"hi! link QuickHelp QuickDefaultHelp
"hi! link QuickBorder QuickDefaultBorder
"hi! link QuickTermBorder QuickDefaultTermBorder
"hi! link QuickPreview QuickDefaultPreview

finish

