" author: Sihle Mhlongo
"
" created: 25/12/2023
" updated: 09/09/2025

nnoremap <esc><esc> :nohlsearch<cr>

nnoremap <leader>y "+y
nnoremap <leader>p "+p

nnoremap <leader>- <cmd>sp<cr>
nnoremap <leader>\| <cmd>vsp<cr>
nnoremap <leader>H 20<c-w><
nnoremap <leader>L 20<c-w>>

noremap <leader><leader> z.

nnoremap <leader>ek <cmd>tab :drop $CONFIG/keymaps.vim<cr>
nnoremap <leader>ep <cmd>tab :drop $CONFIG/lua/plugins.lua<cr>
nnoremap <leader>el <cmd>tab :drop $CONFIG/lua/plugins/lsp.lua<cr>
nnoremap <leader>ev <cmd>tab :drop $MYVIMRC<cr>
nnoremap <leader>sv <cmd>source $MYVIMRC<cr>
nnoremap <leader>= m0gg=G`0m0

vnoremap <leader>" mz<esc>`>a"<esc>`<i"<esc>`zmzl
vnoremap <leader>' mz<esc>`>a'<esc>`<i'<esc>`zmzl

" evaluate expressions
vnoremap <leader>e s<c-r>=eval(trim(@"))<cr>

let g:snippets_dir = $CONFIG . "/snippets/"

function! EditSnippets(snippets_dir)
   if !empty(&filetype)
      execute "tab :drop " . a:snippets_dir . &filetype . ".snippets"
   endif
endfunction

nnoremap <silent> <leader>es :call EditSnippets(g:snippets_dir)<cr>


augroup filetype_based_mappings
   autocmd!
   autocmd Filetype help nnoremap <buffer> <cr> <c-]>
   autocmd Filetype help nnoremap <buffer> <bs> <c-o>
   autocmd Filetype arduino nnoremap <silent><buffer> <leader>u <cmd>ArduinoUpload<cr>
   autocmd Filetype vim nnoremap <silent><buffer> <leader>r :source %<cr>:echo 'sourced "'.expand('%').'"'<cr>
   autocmd Filetype vim noremap <silent><buffer> <leader><leader> "zyy:<c-r>z<cr>:echo 'sourced line'<cr>
   autocmd Filetype lua nnoremap <silent><buffer> <leader>r :luafile %<cr>:echo 'sourced "'.expand('%').'"'<cr>
   autocmd Filetype lua nnoremap <silent><buffer> <leader><leader> "zyy:lua <c-r>z<cr>:echo 'sourced line'<cr>
   autocmd Filetype qf nnoremap <silent><buffer> :q<cr>

   autocmd Filetype yaml vnoremap <silent><buffer> <leader>$ <esc>magvs$$<esc>P`alma
   autocmd Filetype yaml nmap <silent><buffer> <leader>$ v<leader>$
   autocmd Filetype yaml vmap <silent><buffer> $ <leader>$
   autocmd Filetype yaml vnoremap <silent><buffer> * <esc>magvs**<esc>P`amal
   autocmd Filetype yaml vnoremap <silent><buffer> _ <esc>magvs__<esc>P`amal
   " autocmd Filetype yaml inoremap <silent><buffer> $ $$<left>
augroup END

vnoremap <c-c> "+y

" smart indenting paste
nnoremap p p==
nnoremap P P==

" absolute end / start
nnoremap gg gg^
nnoremap G G$

" line wrap compatible movements
nnoremap <silent> k gk
nnoremap <silent> j gj
" nnoremap <silent> 0 g0
" nnoremap <silent> $ g$

" easy window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
