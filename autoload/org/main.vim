let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/getlanguage.py'
let g:language_path = get(g:, 'language_path', ' ')

"echo g:language_path['python']
"
func! org#main#runCodeBlock()
    let curLineText =  getline('.')
    let codeBlockStartLN  = getpos('.')[1] + 1
    execute(':normal e')
    execute('/```')
    execute(':nohl')
    let codeBlockEndLN  = getpos('.')[1] - 1
    execute('py3f ' . expand(s:path))

    if b:language == ''
        echo 'Not find language'
    else
        if b:language=='go'
            let gofile = expand('%<') . ".go"
            call system("sed -n '" . expand(codeBlockStartLN) . "," . expand(codeBlockEndLN) . "p' " . expand('%') . "> " . expand(gofile))
            let cpgf = split(gofile, '/')[-1]
            let resultText = system("(cd " . expand('%:h') . " && " . expand(g:language_path[b:language]) . " build -o tmp " . expand(cpgf) . " && ./tmp && rm tmp)")
            call system("rm " . expand(gofile))

        elseif b:language == 'c'
            let cfile = expand('%<') . ".c"
            call system("sed -n '" . expand(codeBlockStartLN) . "," . expand(codeBlockEndLN) . "p' " . expand('%') . "> " . expand(cfile))
            let resultText = system(expand(g:language_path[b:language]) . " " . expand(cfile) . " -Wall -o " . expand('%<') . " && " . expand('%<') . " && rm " . expand('%<'))
            call system("rm " . expand(cfile))
        else
            let resultText = system("sed -n '" . expand(codeBlockStartLN) . "," . expand(codeBlockEndLN) . "p' " . expand('%') . "| " . expand(g:language_path[b:language]))
        endif

        let resultList = split(resultText, '\n')
        if resultText == ""
            let resultText = "No message output!"
        let opts = {'title': 'result', 'border':5}
        call org#listbox#inputlist(resultList, opts)
    endif
endfunc
"call org#main#runCodeBlock()

finish
"call org#main#runCodeBlock()

func org#main#test()
    let a = 55
    let b = 59
    "execute(':36,42w !python > tmp') . expand(xxx))
    let xxx = system("sed -n '" . expand(a) . "," . expand(b) . "p' " . expand('%') . '| python')
    let x = split(xxx, '\n')
    "let nx = len(x)
    "for i in range(nx)
    let content = x
    let opts = {'title': 'result', 'border':5}
    call org#listbox#inputlist(content, opts)
endfunc
"call org#main#test()
func Test()
    let a = 'go'
    if a=='golang' || a == 'go'
        echo a
    endif
endfunc

"call Test()
finish
print("ffakj flaf")
print(0)
print(0)
print(0)
print(0)
