let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/getlanguage.py'

func org#main#runCodeBlock()
    let curLineText =  getline('.')
    let codeBlockStartLN  = getpos('.')[1]
    let codeBlockEndLN = execute('/```')
    execute('py3f ' . expand(s:path))
    execute(expand(codeBlockStartLN) . ',' . expand(codeBlockEndLN) . '!python')
endfunc

call org#main#runCodeBlock()


























