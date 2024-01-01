" Sphe M | Steampunk08 vimrc 2

echo "hello from vimrc"

let g:disarmed = v:false

if !exists('g:VIMRC_HAS_BEEN_SOURCED') || g:disarmed
   let maplocalleader = "="
   let mapleader = "<space>"

   let g:VIMRC_MINIMAL_SETUP_MODE = v:true
   let g:VIMRC_HAS_BEEN_SOURCED = "2.1.2"

endif
" let g:vim_indent_cont = 0
" let g:path_separator = "/"

try
   colorscheme steampunklights
catch /E185/
   colorscheme zellner 
endtry

" NOTE: section is reserved for misc. autocommands
" autocmd {{{
augroup VIMSCRIPT
   autocmd!
   autocmd FileType vim setlocal foldmethod=marker foldlevel=0
   autocmd Filetype help nnoremap <buffer> <cr> <c-]>
   autocmd Filetype vifm setfiletype vim
augroup END

augroup FILETYPE_SPERCIFIC
   autocmd!
   autocmd Filetype zsh,sh setlocal iskeyword+=-
   autocmd Filetype help setlocal iskeyword+=- iskeyword+=# iskeyword+=:
   autocmd Filetype help nmap <bs> <c-o>
   autocmd Filetype html setlocal matchpairs-=<:>
   autocmd Filetype kivy setlocal shiftwidth=4 commentstring=#%s
augroup END

augroup EDITOR_MODE
   autocmd Filetype markdown setlocal textwidth=80
   autocmd Filetype gitcommit setlocal spell
augroup END

augroup SETTING_FILETYPES
   autocmd!
   autocmd BufNewFile,BufRead prompt_*_setup setfiletype zsh
   " autocmd BufNewFile,BufRead *.vifm setfiletype vim
   " autocmd BufNewFile,BufRead *.fish setfiletype zsh
   autocmd BufNewFile,BufRead crontabs.* setfiletype crontab
augroup END
" }}}

" NOTE: section is reserved for user defined commands
" commands {{{
command! We w | e
command! Cd execute 'cd ' . expand('%:h')
" }}}

syntax on
"redraw!
" vim:ts=3:sts=3:sw=3:et
