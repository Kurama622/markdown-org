if 1
	let content = [
				\ [ 'python', 'echo 100' ],
				\ [ 'vim', 'echo 200' ],
				\ [ 'go', 'echo 300' ],
				\ [ 'lua' ],
				\ [ 'c++', 'echo 500' ],
				\]
	let opts = {'title': 'Select ', 'border': '3'}
	call org#listbox#open(content, opts)

endif

if 0
	let linelist = [
				\ "line 1",
				\ "line 2",
				\ "line 3" ]
	echo org#listbox#inputlist(linelist, {'title':'select'})
endif
