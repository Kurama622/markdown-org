import vim
import os


b = vim.current.buffer
startList = vim.eval("b:startList")
endList = vim.eval("b:endList")
language = vim.eval("b:language")
selectLang = vim.eval("a:selectLang")


print(selectLang)
print(language)

selectIndex = [i for (i, v) in enumerate(language) if v == selectLang]

if selectLang == 'go':
    for idx in selectIndex:
        print(startList[idx])
        gofile = vim.eval("expand('%<') . '.go'")
        os.system("sed -n '{},{}p' {} >> {}".format(int(startList[idx])+1, int(endList[idx])-1, vim.eval("expand('%')"), gofile) )
