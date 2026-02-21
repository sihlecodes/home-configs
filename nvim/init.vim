" Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" ~/.config/nvim/options.vim
" ~/.config/nvim/keymaps.vim
" ~/.config/nvim/lua/plugins.lua

let g:mapleader = "\<space>"

let $CONFIG = stdpath("config")

source $CONFIG/options.vim
source $CONFIG/keymaps.vim

lua require('init')

command! We w | e
command! Cd cd %:h
command! Path echo expand('%:p')

augroup qol_hacks
   autocmd!
   autocmd WinEnter * setlocal cursorline
   autocmd WinLeave * setlocal nocursorline
   autocmd WinResized * setlocal scroll=8

   " reload files from disk
   autocmd WinEnter * silent! checktime
   autocmd CursorHold * silent! checktime
augroup END

function MarkdownStrikeLine()
   if getline('.') =~ '\~\~'
      s/\~\~//g
   else
      s/^\|$/\~\~/g
   endif
endfunction

augroup additional
   autocmd!
   autocmd BufRead,BufNewFile *.ejs set filetype=embedded_template
   autocmd FileType markdown nnoremap <buffer> <leader>ss :call MarkdownStrikeLine()<CR>
augroup END
