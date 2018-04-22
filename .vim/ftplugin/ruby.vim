color slate
inoremap \|\| \|\|<Left>

# Save and run file.
autocmd FileType ruby nnoremap <F5> :w<CR>:!ruby %<CR>
