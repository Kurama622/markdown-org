if 1
    let content = [
                \ [ " \t python", 'echo 100' ],
                \ [ " \t vim", 'echo 200' ],
                \]
    let opts = {'title': 'Select A Language', 'border':'2'}
    call org#listbox#open(content, opts)
endif

if 0
	let linelist = [
				\ "line 1",
				\ "line 2",
				\ "line 3" ]
	echo org#listbox#inputlist(linelist, {'title':'select'})
endif
