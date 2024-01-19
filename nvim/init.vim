" Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" ~/.config/nvim/keymaps.vim
" ~/.config/nvim/lua/plugins.lua

let g:mapleader = "\<space>"

let $CONFIG = stdpath("config")

source $CONFIG/options.vim
source $CONFIG/keymaps.vim

lua require('init')

command! We w | e
command! Cd cd %:h
