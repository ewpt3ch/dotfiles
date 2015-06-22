" load pathogen
execute pathogen#infect()

" disable vi compatibility
set nocompatible

" colorscheme
set background=dark
colorscheme pencil
let g:airline_theme = 'pencil'
" display line numbers
set nu

" toggle highlight line
nnoremap <silent> <F4> :set cursorline!<CR>

" enable syntax highlighting
syntax enable

" set up indenting
set tabstop=2
set shiftwidth=2
set expandtab
filetype plugin indent on

" 
iabbrev <// </<C-X><C-O>
