import vim
import re


b = vim.current.buffer
curLineText = vim.eval("curLineText")

start, end = re.search(r'[a-zA-Z0-9]+', curLineText).span()
b.vars['language'] = curLineText[start:end]

