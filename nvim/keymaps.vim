" author: Sihle Mhlongo
"
" created: 25/12/2023
" updated: 25/12/2023

nnoremap <esc><esc> :nohlsearch<cr>

nnoremap <silent> <leader>y :let @+ = @"<cr>

nnoremap <leader><leader> "zyy:<c-r>z<cr>
vnoremap <leader><leader> "zyq:i<c-r>z
nnoremap <leader>ek :Tabedit $CONFIG/keymaps.vim<cr>
nnoremap <leader>ep :Tabedit $CONFIG/lua/plugins.lua<cr>
nnoremap <leader>ev :Tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

let g:snippets_dir = $CONFIG . "/snippets/"

function! EditSnippets(snippets_dir)
   if !empty(&filetype)
      execute "Tabedit " . a:snippets_dir . &filetype . ".snippets"
   endif
endfunction

nnoremap <silent> <leader>es :call EditSnippets(g:snippets_dir)<cr>

" smart indenting paste
nnoremap p p==
nnoremap P P==

" absolute end / start
nnoremap gg gg^
nnoremap G G$

" line wrap compatible movements
nnoremap <silent> k gk
nnoremap <silent> j gj
nnoremap <silent> 0 g0
nnoremap <silent> $ g$

" easy window navigation
nnoremap <c-h> <c-w>h
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
