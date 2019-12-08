nmap <F5> :!clisp % <RETURN>
nmap <F6> :!clisp -i % <RETURN>
imap ** **<LEFT>


" Supposed to let you wrap an () expression
" with an additional () so you can work from
" the outside in.
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


" Add the item from the left of the current expression
" into the expression
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


" Expel the leftmost item from the current expression
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


" Add the item from the right of the current expression
" into the expression
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


" Expel the rightmost item from the current expression
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

" Think of the shortcuts as in/out left/right
" More convenient than angle brackets
nmap i( :call SlurpLeft()<cr>
nmap o( :call BarfLeft()<cr>
nmap i) :call SlurpRight()<cr>
nmap o) :call BarfRight()<cr>
