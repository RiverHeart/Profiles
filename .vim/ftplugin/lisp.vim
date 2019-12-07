nmap <F5> :!clisp % <RETURN>
nmap <F6> :!clisp -i % <RETURN>
imap ** **<LEFT>


function NestExpression()
    " Get end paren pos
    " Returns [0, 0] if not in parens.
    let save_cursor = getpos('.')

    " If line not set to zero, append
    let end_paren_pos = searchpairpos('(', '', ')')
    if end_paren_pos[0] > 0
        execute "normal! a)"
    else
        " We're not in a set of parentheses
        return  
    endif

    " Return to the inside of the parentheses
    call setpos('.', save_cursor)

    " If line not set to zero, start insert
    " mode, prepend and move cursor left
    let end_paren_pos = searchpairpos('(', '', ')', 'b')
    if end_paren_pos[0] > 0
        call feedkeys("i( \<LEFT>")
    endif
endfunction


function SlurpLeft()
    let save_cursor = getpos('.')

    let paren_pos = searchpair('(', '', ')', 'b')
    if paren_pos == 0
        " We're not in a set of parentheses
        return  
    endif

    execute "normal! x"
    execute "normal! b"
    " TODO: Check if we're on a paren. If so, we've hit the end of the
    " previous sexp
    execute "normal! P"
    
    " Return to the inside of the parentheses
    call setpos('.', save_cursor)
endfunction


function BarfLeft()
    let save_cursor = getpos('.')

    let paren_pos = searchpair('(', '', ')', 'b')
    if paren_pos == 0
        " We're not in a set of parentheses
        return  
    endif

    execute "normal! w"
    " TODO: Check if not end paren
    execute "normal! dw"

    let paren_pos = searchpair('(', '', ')', 'b')
    execute "normal! P"
endfunction


function SlurpRight()
    let save_cursor = getpos('.')

    let paren_pos = searchpair('(', '', ')')
    if paren_pos == 0
        " We're not in a set of parentheses
        return  
    endif

    execute "normal! x"
    execute "normal! e"
    " TODO: Check if we're on a paren. If so, we've hit the end of the
    " previous sexp
    execute "normal! p"
    
    " Return to the inside of the parentheses
    call setpos('.', save_cursor)
endfunction


function BarfRight()
    let save_cursor = getpos('.')

    let paren_pos = searchpair('(', '', ')')
    if paren_pos == 0
        " We're not in a set of parentheses
        return  
    endif

    execute "normal! x"
    execute "normal! b"
    execute "normal! i)"
    
    " Return to the inside of the parentheses
    call setpos('.', save_cursor)
endfunction


nmap fj :call NestExpression()<cr>

" Angle bracket indicates direction to shift paren
" Think of it as in/out. i/o are closer to parens
" than angle brackets.
nmap i( :call SlurpLeft()<cr>
nmap o( :call BarfLeft()<cr>
nmap i) :call SlurpRight()<cr>
nmap o) :call BarfRight()<cr>
