" author: Sihle Mhlongo
"
" created: 25/12/2023
" updated: 08/01/2024

nnoremap <esc><esc> :nohlsearch<cr>

nnoremap <leader>y "+y
nnoremap <leader>p "+p

nnoremap <leader>- <cmd>sp<cr>
nnoremap <leader>\ <cmd>vsp<cr>

noremap <leader><leader> z.

nnoremap <leader>ek <cmd>tab :drop $CONFIG/keymaps.vim<cr>
nnoremap <leader>ep <cmd>tab :drop $CONFIG/lua/plugins.lua<cr>
nnoremap <leader>el <cmd>tab :drop $CONFIG/lua/plugins/lsp.lua<cr>
nnoremap <leader>ev <cmd>tab :drop $MYVIMRC<cr>
nnoremap <leader>sv <cmd>source $MYVIMRC<cr>
nnoremap <leader>= m0gg=G`0m0

let g:snippets_dir = $CONFIG . "/snippets/"

function! EditSnippets(snippets_dir)
   if !empty(&filetype)
      execute "tab :drop " . a:snippets_dir . &filetype . ".snippets"
   endif
endfunction

nnoremap <silent> <leader>es :call EditSnippets(g:snippets_dir)<cr>

" evaluate expressions
vnoremap <leader>e s<c-r>=eval(trim(@"))<cr>

augroup filetype_based_mappings
   autocmd!
   autocmd Filetype help nnoremap <buffer> <cr> <c-]>
   autocmd Filetype help nnoremap <buffer> <bs> <c-o>
   autocmd Filetype arduino nnoremap <buffer> <leader>u <cmd>ArduinoUpload<cr>
   autocmd Filetype vim nnoremap <silent><buffer> <leader>r :source %<cr>:echo 'sourced "'.expand('%').'"'<cr>
   autocmd Filetype vim noremap <leader><leader> "zyy:<c-r>z<cr>
   autocmd Filetype lua nnoremap <silent><buffer> <leader>r :luafile %<cr>:echo 'sourced "'.expand('%').'"'<cr>
   autocmd Filetype lua nnoremap <silent><buffer> <leader><leader> "zyy:lua <c-r>z<cr>
   autocmd Filetype qf nnoremap <silent><buffer> :q<cr>
augroup END

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
