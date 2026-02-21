" author: sihlecodes
"
" created: 25/12/2023
" updated: 30/03/2026

set undofile
set clipboard=unnamedplus
set nowrap scroll=8
set shell=$SHELL
set showcmd wildmenu mouse=a
set numberwidth=3 number relativenumber
set encoding=utf8 backspace=indent,eol,start
set showtabline=1 laststatus=2 cursorline
set softtabstop=3 tabstop=3 expandtab shiftwidth=0
set history=450
set incsearch hlsearch
set smartcase smarttab smartindent autoread
set t_Co=256 undodir=~/.config/nvim/undo
set signcolumn=yes foldcolumn=0
set splitright fillchars+=fold:-
set completeopt=menu,menuone,popup

augroup conditional_options
   autocmd!
   autocmd Filetype yaml setlocal wrap
augroup END
