"======================================================================
"
" core.vim - 
"
" Created by skywind on 2019/12/18
" Last Modified: 2019/12/18 15:58:00
"
"======================================================================

" vim: set noet fenc=utf-8 ff=unix sts=4 sw=4 ts=4 :


"======================================================================
" core routines
"======================================================================

"----------------------------------------------------------------------
" global variables
"----------------------------------------------------------------------
let g:org#core#has_nvim = has('nvim')
let g:org#core#has_popup = exists('*popup_create') && v:version >= 800
let g:org#core#has_floating = has('nvim-0.4')


"----------------------------------------------------------------------
" internal variables
"----------------------------------------------------------------------


"----------------------------------------------------------------------
" object pool acquire
"----------------------------------------------------------------------
function! org#core#object_acquire(name)
	if !exists('g:org#core#__object_pool__')
		let g:org#core#__object_pool__ = {}
	endif
	if !has_key(g:org#core#__object_pool__, a:name)
		let g:org#core#__object_pool__[a:name] = []
	endif
	let array = g:org#core#__object_pool__[a:name]
	if len(array) == 0
		return v:null
	endif
	let obj = remove(array, -1)	
	return obj
endfunc


"----------------------------------------------------------------------
" object pool release
"----------------------------------------------------------------------
function! org#core#object_release(name, obj)
	if !exists('g:org#core#__object_pool__')
		let g:org#core#__object_pool__ = {}
	endif
	if !has_key(g:org#core#__object_pool__, a:name)
		let g:org#core#__object_pool__[a:name] = []
	endif
	call add(g:org#core#__object_pool__[a:name], a:obj)
endfunc


"----------------------------------------------------------------------
" replace string
"----------------------------------------------------------------------
function! org#core#string_replace(text, old, new)
	let l:data = split(a:text, a:old, 1)
	return join(l:data, a:new)
endfunc


"----------------------------------------------------------------------
" compose two string
"----------------------------------------------------------------------
function! org#core#string_compose(target, pos, source)
	if a:source == ''
		return a:target
	endif
	let pos = a:pos
	let source = a:source
	if pos < 0
		let source = strcharpart(a:source, -pos)
		let pos = 0
	endif
	let target = strcharpart(a:target, 0, pos)
	if strchars(target) < pos
		let target .= repeat(' ', pos - strchars(target))
	endif
	let target .= source
	let target .= strcharpart(a:target, pos + strchars(source))
	return target
endfunc


"----------------------------------------------------------------------
" fit size
"----------------------------------------------------------------------
function! org#core#string_fit(source, size)
	let require = a:size
	let source = a:source
	let size = len(source)
	if size <= require
		return source
	endif
	if require <= 2
		return repeat('.', (require < 0)? 0 : require)
	endif	
	let avail = require - 2
	let left = avail / 2
	let right = avail - left
	let p1 = strpart(source, 0, left)
	let p2 = strpart(source, size - right)
	let text = p1 . '..' . p2
	return text
endfunc


"----------------------------------------------------------------------
" eval & expand: '%{script}' in string
"----------------------------------------------------------------------
function! org#core#expand_text(string) abort
	let partial = []
	let index = 0
	while 1
		let pos = stridx(a:string, '%{', index)
		if pos < 0
			let partial += [strpart(a:string, index)]
			break
		endif
		let head = ''
		if pos > index
			let partial += [strpart(a:string, index, pos - index)]
		endif
		let endup = stridx(a:string, '}', pos + 2)
		if endup < 0
			let partial += [strpart(a:stirng, index)]
			break
		endif
		let index = endup + 1
		if endup > pos + 2
			let script = strpart(a:string, pos + 2, endup - (pos + 2))
			let script = substitute(script, '^\s*\(.\{-}\)\s*$', '\1', '')
			let result = eval(script)
			let partial += [result]
		endif
	endwhile
	return join(partial, '')
endfunc


"----------------------------------------------------------------------
" escape key character (starts by &) from string
"----------------------------------------------------------------------
function! org#core#escape(text)
	let text = a:text
	let rest = ''
	let start = 0
	let obj = ['', '', -1, -1, -1]
	while 1
		let pos = stridx(text, '&', start)
		if pos < 0
			let rest .= strpart(text, start)
			break
		end
		let rest .= strpart(text, start, pos - start)
		let key = strpart(text, pos + 1, 1)
		let start = pos + 2
		if key == '&'
			let rest .= '&'
		elseif key == '~'
			let rest .= '~'
		else
			let obj[1] = key
			let obj[2] = strlen(rest)
			let obj[3] = strchars(rest)
			let obj[4] = strdisplaywidth(rest)
			let rest .= key
		endif
	endwhile
	let obj[0] = rest
	return obj
endfunc


"----------------------------------------------------------------------
" list parse
"----------------------------------------------------------------------
function! org#core#single_parse(description)
	let item = { 'part': [], 'size': 0 }
	let item.key_char = ''
	let item.key_pos = -1
	let item.key_idx = -1
	if type(a:description) == v:t_string
		let text = a:description
		let item.cmd = ''
	elseif type(a:description) == v:t_list
		let size = len(a:description)
		let text = (size > 0)? a:description[0] : ''
		let item.cmd = (size > 1)? a:description[1] : ''
	endif
	for text in split(text, "\t")
		let obj = org#core#escape(text)
		let item.part += [obj[0]]
		if obj[2] >= 0 && item.key_idx < 0
			let item.key_char = obj[1]
			let item.key_pos = obj[4]
			let item.key_idx = item.size
		endif
		let item.size += 1
	endfor
	return item
endfunc


"----------------------------------------------------------------------
" tabpage instance
"----------------------------------------------------------------------
function! org#core#instance()
	if exists('t:__org__')
		return t:__org__
	endif
	let t:__org__ = {}
	return t:__org__
endfunc


"----------------------------------------------------------------------
" buffer instance
"----------------------------------------------------------------------
function! org#core#object(bid)
	let name = '__org__'
	let bid = (a:bid > 0)? a:bid : (bufnr())
	if bufexists(bid) == 0
		return v:null
	endif
	let obj = getbufvar(bid, name)
	if type(obj) != v:t_dict
		call setbufvar(bid, name, {})
		let obj = getbufvar(bid, name)
	endif
	return obj
endfunc


"----------------------------------------------------------------------
" object cache: acquire
"----------------------------------------------------------------------
function! org#core#popup_alloc(name)
	let inst = org#core#instance()
	if !has_key(inst, 'popup_cache')
		let inst.popup_cache = {}
	endif
	if !has_key(inst.popup_cache, a:name)
		let inst.popup_cache[a:name] = []
	endif
	if !empty(inst.popup_cache[a:name])
		let winid = remove(inst.popup_cache[a:name], -1)
		return winid
	endif
	let opts = {"line":1, "col":1, "wrap":0, "pos": 'topleft'}
	let winid = popup_create([], opts)
	call popup_hide(winid)
	call win_execute(winid, 'setlocal nonumber nowrap signcolumn=no')
	call setwinvar(winid, '&wincolor', '')
	return winid
endfunc


"----------------------------------------------------------------------
" object cache: release
"----------------------------------------------------------------------
function! org#core#popup_release(name, winid)
	let inst = org#core#instance()
	if !has_key(inst, 'popup_cache')
		let inst.popup_cache = {}
	endif
	if !has_key(inst.popup_cache, a:name)
		let inst.popup_cache[a:name] = []
	endif
	silent! call popup_hide(a:winid)
	let size = len(inst.popup_cache[a:name])
	call insert(inst.popup_cache[a:name], a:winid, size)	
endfunc


"----------------------------------------------------------------------
" local object
"----------------------------------------------------------------------
function! org#core#popup_local(winid)
	let inst = org#core#instance()
	if !has_key(inst, 'popup_local')
		let inst.popup_local = {}
	endif
	if !has_key(inst.popup_local, a:winid)
		let inst.popup_local[a:winid] = {}
	endif
	return inst.popup_local[a:winid]
endfunc


"----------------------------------------------------------------------
" erase local data
"----------------------------------------------------------------------
function! org#core#popup_clear(winid)
	let inst = org#core#instance()
	if !has_key(inst, 'popup_local')
		let inst.popup_local = {}
	endif
	if has_key(inst.popup_local, a:winid)
		call remove(inst.popup_local, a:winid)
	endif
endfunc


"----------------------------------------------------------------------
" vim/nvim compatible
"----------------------------------------------------------------------
function! org#core#win_execute(winid, command)
	if g:org#core#has_popup != 0
		if type(a:command) == v:t_string
			keepalt call win_execute(a:winid, a:command)
		elseif type(a:command) == v:t_list
			keepalt call win_execute(a:winid, join(a:command, "\n"))
		endif
	else
		let current = nvim_get_current_win()
		keepalt call nvim_set_current_win(a:winid)
		if type(a:command) == v:t_string
			exec a:command
		elseif type(a:command) == v:t_list
			exec join(a:command, "\n")
		endif
		keepalt call nvim_set_current_win(current)
	endif
endfunc


"----------------------------------------------------------------------
" get a named buffer
"----------------------------------------------------------------------
function! org#core#scratch_buffer(name, textlist)
	if !exists('s:buffer_cache')
		let s:buffer_cache = {}
	endif
	if a:name != ''
		let bid = get(s:buffer_cache, a:name, -1)
	else
		let bid = -1
	endif
	if bid < 0
		if g:org#core#has_nvim == 0
			let bid = bufadd('')
			call bufload(bid)
			call setbufvar(bid, '&buflisted', 0)
			call setbufvar(bid, '&bufhidden', 'hide')
		else
			let bid = nvim_create_buf(v:false, v:true)
		endif
		if a:name != ''
			let s:buffer_cache[a:name] = bid
		endif
	endif
	call setbufvar(bid, '&modifiable', 1)
	call deletebufline(bid, 1, '$')
	call setbufline(bid, 1, a:textlist)
	call setbufvar(bid, '&modified', 0)
	call setbufvar(bid, 'current_syntax', '')
	call setbufvar(bid, '&filetype', '')
	return bid
endfunc


"----------------------------------------------------------------------
" dummy filter
"----------------------------------------------------------------------
function! org#core#mock_function(id, text)
	return 0
endfunc


"----------------------------------------------------------------------
" highlight region
"----------------------------------------------------------------------
function! org#core#high_region(name, srow, scol, erow, ecol, virtual)
	let sep = (a:virtual == 0)? 'c' : 'v'
	let cmd = 'syn region ' . a:name . ' '
	let cmd .= ' start=/\%' . a:srow . 'l\%' . a:scol . sep . '/'
	let cmd .= ' end=/\%' . a:erow . 'l\%' . a:ecol . sep . '/'
	return cmd
endfunc


"----------------------------------------------------------------------
" patterns
"----------------------------------------------------------------------
function! org#core#border_extract(pattern)
	let parts = ['', '', '', '', '', '', '', '', '', '', '']
	for idx in range(11)
		let parts[idx] = strcharpart(a:pattern, idx, 1)
	endfor
	return parts
endfunc


function! org#core#border_convert(pattern)
	if type(a:pattern) == v:t_string
		let p = org#core#border_extract(a:pattern)
	else
		let p = a:pattern
	endif
	let pattern = [ p[1], p[5], p[7], p[3], p[0], p[2], p[8], p[6] ]
	return pattern
endfunc

let s:border_styles = {}

let s:border_styles[1] = org#core#border_extract('+-+|-|+-+++')
let s:border_styles[2] = org#core#border_extract('┌─┐│─│└─┘├┤')
let s:border_styles[3] = org#core#border_extract('╔═╗║─║╚═╝╟╢')
let s:border_styles[4] = org#core#border_extract('/-\|-|\-/++')
let s:border_styles[5] = org#core#border_extract('╭─╮│─│╰─╯├┤')

"let s:border_ascii = org#core#border_extract('+-+|-|+-+++')
let s:border_ascii = org#core#border_extract('╭─╮│─│╰─╯├┤')

function! org#core#border_install(name, pattern)
	let s:border_styles[a:name] = org#core#border_extract(a:pattern)
endfunc

function! org#core#border_get(name)
	if has_key(s:border_styles, a:name)
		return s:border_styles[a:name]
	endif
	return s:border_ascii
endfunc

function! org#core#border_vim(name)
	let border = org#core#border_get(a:name)
	return org#core#border_convert(border)
endfunc


"----------------------------------------------------------------------
" returns cursor position for screen coordination
"----------------------------------------------------------------------
function! org#core#cursor_pos()
	let pos = win_screenpos('.')
	return [pos[0] + winline() - 1, pos[1] + wincol() - 1]
endfunc


"----------------------------------------------------------------------
" screen boundary check, returns 1 for in screen, 0 for exceeding
"----------------------------------------------------------------------
function! org#core#in_screen(line, column, width, height)
	let x = a:column - 1
	let y = a:line - 1
	let w = a:width
	let h = a:height
	let screenw = &columns
	let screenh = &lines
	return (x >= 0 && y >= 0 && x + w <= screenw && y + h <= screenh)? 1 : 0
endfunc


"----------------------------------------------------------------------
" window fit screen
"----------------------------------------------------------------------
function! org#core#screen_fit(line, column, width, height)
	let x = a:column - 1
	let y = a:line - 1
	let w = a:width
	let h = a:height
	let screenw = &columns
	let screenh = &lines
	let x = (x + w > screenw)? screenw - w : x
	let y = (y + h > screenh)? screenh - h : y
	let x = (x < 0)? 0 : x
	let y = (y < 0)? 0 : y
	return [y + 1, x + 1]
endfunc


"----------------------------------------------------------------------
" fit screen
"----------------------------------------------------------------------
function! org#core#around_cursor(width, height)
	let cursor_pos = org#core#cursor_pos()
	let row = cursor_pos[0] + 1
	let col = cursor_pos[1] + 1
	if org#core#in_screen(row, col, a:width, a:height)
		return [row, col]
	endif
	if col + a:width - 1 > &columns
		let col = col - (1 + a:width)
		if org#core#in_screen(row, col, a:width, a:height)
			return [row, col]
		endif
	endif
	if row + a:height - 1 > &lines
		let row = row - (1 + a:height)
		if org#core#in_screen(row, col, a:width, a:height)
			return [row, col]
		endif
	endif
	if cursor_pos[0] + a:height + 2 < &lines
		let row = cursor_pos[0] + 1
	else
		let row = cursor_pos[0] - a:height
	endif
	if cursor_pos[1] + a:width + 2 < &columns
		let col = cursor_pos[1] + 1
	else
		let col = cursor_pos[1] - a:width
	endif
	return org#core#screen_fit(row, col, a:width, a:height)
endfunc


"----------------------------------------------------------------------
" safe input
"----------------------------------------------------------------------
function! org#core#input(prompt, text)
	call inputsave()
	try
		let t = input(a:prompt, a:text)
	catch /^Vim:Interrupt$/
		let t = "\<c-c>"
	endtry
	call inputrestore()
	return t
endfunc


"----------------------------------------------------------------------
" safe change dir
"----------------------------------------------------------------------
function! org#core#chdir(path)
	if has('nvim')
		let cmd = haslocaldir()? 'lcd' : (haslocaldir(-1, 0)? 'tcd' : 'cd')
	else
		let cmd = haslocaldir()? ((haslocaldir() == 1)? 'lcd' : 'tcd') : 'cd'
	endif
	silent execute cmd . ' '. fnameescape(a:path)
endfunc


