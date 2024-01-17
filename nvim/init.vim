" Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" ~/.config/nvim/keymaps.vim
" ~/.config/nvim/lua/plugins.lua
" ~/.config/nvim/after/plugin/lsp.lua
" ~/.config/nvim/after/plugin/cmp.lua
" ~/.config/nvim/after/plugin/lualine.lua

let g:mapleader = "\<space>"

let $CONFIG = stdpath("config")

source $CONFIG/options.vim
source $CONFIG/keymaps.vim

lua require('init')
lua require('plugins')

command! We w | e
command! Cd cd %:h
