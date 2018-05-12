colorscheme murphy

set nocompatible   " No backwards compatibility with Vi
set modeline       " Autodetect filetype based on shebang for extensionless files.
set title
set number         " Number lines
set incsearch      " Incremental search
set ignorecase     " Ignore case when searching
set scrolloff=5    " Keep at least 5 lines above/below cursor
set completeopt=menu,longest,preview

set expandtab       " Always use spaces for tabs
set tabstop=4       " Tabs are 4 spaces
set shiftwidth=4    " Shift 4 spaces when using '>' or '<'
filetype plugin indent on    " Auto indent based on file ext

inoremap jj <Esc>
inoremap uu ->
inoremap hh <Right>
inoremap ,, <Right>,
inoremap ;; <End>;
inoremap '' ''<Left>
inoremap "" ""<Left>
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap <> <><Left>

" When searching, zz will center the line of the search term.
map N Nzz
map n nzz

" Window Pane Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
