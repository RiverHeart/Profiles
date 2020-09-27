set splitbelow
command -nargs=1 -complete=file Use let db=<q-args>

function Run()
    if exists("g:db")
        execute 'write'
        silent execute '!cat % | sqlite3 ' . g:db . '> /tmp/sql_output'
        pedit +set\ nowrap /tmp/sql_output
        redraw!
    else
        echo "$db unset. Run 'Use $dbname'"
    endif
endfunction

" This affects entire lines, not just selected columns. 
" '<,'> represents selected lines.
function RunSnippet()
    if exists("g:db")
        let l:tmpfile   = tempname() . '.sql'
        execute "'<,'>write! " . l:tmpfile
        silent execute '!cat ' . l:tmpfile . ' | sqlite3 ' . g:db . '> /tmp/sql_output'
        pedit +set\ nowrap /tmp/sql_output
        redraw!
    else
        echo "$db unset. Run 'Use $dbname'"
    endif
endfunction

nnoremap <F5> :call Run()<CR>

" <C-U> flushes command line to prevent '<,'> from being inserted.
vnoremap <F5> :<C-U>call RunSnippet()<CR>
