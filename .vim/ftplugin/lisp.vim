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

nmap fj :call NestExpression()<cr>
