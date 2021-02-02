import vim
import os
import subprocess
import json

b = vim.current.buffer
startList = vim.eval("b:startList")
endList = vim.eval("b:endList")
language = vim.eval("b:language")
selectLang = vim.eval("a:selectLang")
language_path = vim.eval("g:language_path")



selectIndex = [i for (i, v) in enumerate(language) if v == selectLang]

if selectLang == 'go':
    for idx in selectIndex:
        gofile = vim.eval("expand('%<') . '.go'")
        os.system("sed -n '{},{}p' {} >> {}".format(int(startList[idx])+1, int(endList[idx])-1, vim.eval("expand('%')"), gofile) )
        cpgf = gofile.split('/')[-1]
    resultText = subprocess.getstatusoutput("(cd {} && {} build -o tmp {} && ./tmp && rm tmp)".format(vim.eval("expand('%:h')"), language_path[selectLang], cpgf))[-1]
    os.system("rm {}".format(gofile))
    b.vars['resultText'] = resultText

elif selectLang == 'c':
    for idx in selectIndex:
        cfile = vim.eval("expand('%<') . '.c'")
        os.system("sed -n '{},{}p' {} >> {}".format(int(startList[idx])+1, int(endList[idx])-1, vim.eval("expand('%')"), cfile) )
        filename = vim.eval("expand('%<')")
    resultText = subprocess.getstatusoutput("{} {} -Wall -o {} && ./{} && rm {}".format(language_path[selectLang], cfile, filename, filename, filename))[-1]
    os.system("rm {}".format(cfile))
    b.vars['resultText'] = resultText

elif selectLang == 'cpp' or selectLang == 'c++':
    for idx in selectIndex:
        cppfile = vim.eval("expand('%<') . '.cpp'")
        os.system("sed -n '{},{}p' {} >> {}".format(int(startList[idx])+1, int(endList[idx])-1, vim.eval("expand('%')"), cppfile) )
        filename = vim.eval("expand('%<')")
    resultText = subprocess.getstatusoutput("{} -std=c++11 {} -Wall -o {} && ./{} && rm {}".format(language_path[selectLang], cppfile, filename, filename, filename))[-1]
    os.system("rm {}".format(cppfile))
    b.vars['resultText'] = resultText
else:
    for idx in selectIndex:
        os.system("sed -n '{},{}p' {} >> pyfile".format(int(startList[idx])+1, int(endList[idx])-1, vim.eval("expand('%')")))
    resultText = subprocess.getstatusoutput("cat pyfile| {}".format(language_path[selectLang]))[-1]
    os.system("rm pyfile")
    b.vars['resultText'] = resultText
