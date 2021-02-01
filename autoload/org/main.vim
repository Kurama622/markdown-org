let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/getlanguage.py'

func org#main#runCodeBlock()
    try
        let curLineText =  getline('.')
        let codeBlockStartLN  = getpos('.')[1]
        let codeBlockEndLN = execute('/```')
        execute('py3f ' . expand(s:path))       "get b:language
        execute(expand(codeBlockStartLN) . ',' . expand(codeBlockEndLN) . '!python')
endfunc

call org#main#runCodeBlock()


























