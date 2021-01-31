if 1
	let content = [
				\ [ 'echo 1', 'echo 100' ],
				\ [ 'echo 2', 'echo 200' ],
				\ [ 'echo 3', 'echo 300' ],
				\ [ 'echo 4' ],
				\ [ 'echo 5', 'echo 500' ],
				\]
	let opts = {'title': 'select'}
	call org#listbox#open(content, opts)
endif

if 0
	let linelist = [
				\ "line 1",
				\ "line 2",
				\ "line 3" ]
	echo org#listbox#inputlist(linelist, {'title':'select'})
endif
