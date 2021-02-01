let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/getlanguage.py'

"```python
"
"```
func org#main#runCodeBlock()
    let curLineText =  getline('.')
    let codeBlockStartLN  = getpos('.')[1] + 1
    execute(':normal e')
    execute('/```')
    let codeBlockEndLN  = getpos('.')[1] - 1
    execute('py3f ' . expand(s:path))
    "echo codeBlockStartLN
    "echo codeBlockEndLN
    execute(expand(codeBlockStartLN) . ',' . expand(codeBlockEndLN) . 'w !python')
endfunc

"call org#main#runCodeBlock()


























