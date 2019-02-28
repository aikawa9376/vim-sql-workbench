if ( exists('g:loaded_fzf_sw_profiles') && g:loaded_fzf_sw_profiles )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_fzf_sw_profiles = 1

let s:current_buffer = ''

" The action to perform on the selected string
" " Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! fzf#sw_profiles#accept(line) abort
    let command = sw#get_connect_command(a:line[0])
    call sw#sqlwindow#connect_buffer('e', s:current_buffer)
    call sw#sqlwindow#execute_macro(command)
    let s:current_buffer = ''
    if exists('s:position')
        call setpos('.', s:position)
    endif
endfunction

function! fzf#sw_profiles#init()
    call fzf#sw_profiles#enter()

    let profiles = sw#cache_get('profiles')

    let result = []
    for key in keys(profiles)
        call add(result, key)
    endfor
    return result
endfunction

" Allow it to be called later
function! fzf#sw_profiles#id()
	return s:id
endfunction

function! fzf#sw_profiles#enter()
    let s:current_buffer = sw#bufname('%')
    let name = sw#sqlwindow#get_resultset_name()
    call sw#goto_window(name)
    if sw#bufname('%') == name
        bwipeout 
        let s:current_buffer = sw#bufname('%')
    endif
    let s:position = getcurpos()
endfunction
" vim:nofen:fdl=0:ts=4:sw=4:sts=4
