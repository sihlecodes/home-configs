" source ~/.vimrc

lua require('plugins')

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

function! Tabnr(filename)
    for tabnr in range(tabpagenr('$'))
        for winid in tabpagebuflist(tabnr + 1)
            if bufname(winid) == a:filename
                return tabnr + 1
            endif
        endfor
    endfor
    return -1
endfunction

function! OpenTabOrSwitch(file)
   let fname = expand(a:file)
   let bufnr = bufnr(fname)
   let tabnr = Tabnr(fname)

   if tabnr == -1
      execute 'tabedit ' . a:file
   else
      execute tabnr . 'tabnext'
   endif
endfunction

command! -nargs=1 -complete=file Tabedit :call OpenTabOrSwitch(<f-args>)
command! We w | e
command! Cd execute 'cd ' . expand('%:h')
