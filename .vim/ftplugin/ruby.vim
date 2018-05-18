color slate
inoremap \|\| \|\|<Left>

" Save and run file.
nnoremap <F5> :w<CR>:!ruby %<CR>

" This affects entire lines, not just selected columns. Working on something better.
" '<,'> represents selected lines.
function RunSnippet()
    let l:tmpfile   = tempname() . '.rb'
    execute "'<,'>write! " . l:tmpfile
    execute '!ruby ' . l:tmpfile
endfunction

" <C-U> flushes command line to prevent '<,'> from being inserted.
vnoremap <F5> :<C-U>call RunSnippet()<CR>
