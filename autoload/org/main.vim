let s:runCodeBlockPath = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/getlanguage.py'
let s:runLanguagePath = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/recodelanguage.py'
let s:runPath = fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/catCodeBlock.py'
let g:language_path = get(g:, 'language_path', ' ')

"echo g:language_path['python']
"
func! org#main#runCodeBlock()
    execute('?```')
    let curLineText =  getline('.')
    let codeBlockStartLN  = getpos('.')[1] + 1
    execute(':normal e')
    execute('/```')
    execute(':nohl')
    let codeBlockEndLN  = getpos('.')[1] - 1
    execute('py3f ' . expand(s:runCodeBlockPath))

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
            let resultText = system(expand(g:language_path[b:language]) . " " . expand(cfile) . " -Wall -o " . expand('%<') . " && ./" . expand('%<') . " && rm " . expand('%<'))
            call system("rm " . expand(cfile))
        elseif b:language == 'cpp' || b:language == 'c++'
            let cppfile = expand('%<') . ".cpp"
            call system("sed -n '" . expand(codeBlockStartLN) . "," . expand(codeBlockEndLN) . "p' " . expand('%') . "> " . expand(cppfile))
            let resultText = system(expand(g:language_path[b:language]) . " -std=c++11 " . expand(cppfile) . " -Wall -o " . expand('%<') . " && ./" . expand('%<') . " && rm " . expand('%<'))
            call system("rm " . expand(cppfile))
        else
            let resultText = system("sed -n '" . expand(codeBlockStartLN) . "," . expand(codeBlockEndLN) . "p' " . expand('%') . "| " . expand(g:language_path[b:language]))
        endif

        if resultText == ""
            let resultText = "No message output!"
        endif
        let resultList = split(resultText, '\n')
        let opts = {'index':g:org#listbox#cursor, 'title': 'RESULT', 'border':g:org#style#border, 'bordercolor':g:org#style#bordercolor}
        call org#listbox#inputlist(resultList, opts)
    endif
endfunc

func! org#main#runLanguage()
    let blockStart = system("grep -n \"^\\`\\`\\`[a-zA-Z\\-\\\\+0-9]\\+\" " . expand('%') . " > tmp |awk -F: '{print $1}' tmp && rm tmp")
    let blockEnd = system("grep -wn \"^\\`\\`\\`\" " . expand('%') . " > tmp |awk -F: '{print $1}' tmp && rm tmp")
    let b:startList = split(blockStart)
    let b:endList = split(blockEnd)
    execute('py3f ' . expand(s:runLanguagePath))
    let opts = {'title': 'SELECT A LANGUAGE', 'border':g:org#style#border, 'bordercolor':g:org#style#bordercolor}
    call org#listbox#open(b:content, opts)
endfunc


func! org#main#run(selectLang)
    execute('py3f ' . expand(s:runPath))
    if b:resultText == ""
        let b:resultText = "No message output!"
    endif
    let resultList = split(b:resultText, '\n')
    let opts = {'title': 'RESULT', 'border':g:org#style#border, 'bordercolor':g:org#style#bordercolor}
    call org#listbox#inputlist(resultList, opts)
endfunc

"call org#main#runLanguage()

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
finish
