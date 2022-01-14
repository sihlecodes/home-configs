" helper functions {{{
" SynName() {{{
function! SynName()
   let synname = synIDattr(synID(line("."), col("."), 1), "name")
   return empty(synname) ? "Normal" : synname
endfunction
" }}}
" Modifiable() {{{
function! Modifiable()
   return !&modifiable || &readonly ? nr2char(57506) : ''
endfunction
" }}}
" ModFlag() {{{
function! ModFlag()
   return &modified ? '*' : ''
endfunction
" }}}
" WordCount() {{{
function! WordCount()
   return wordcount()[has_key(wordcount(), 'visual_words') ? 'visual_words' : 'words']
endfunction
" }}}
" CharCount() {{{
function! CharCount()
   return wordcount()['chars']
endfunction
" }}}
" FileName() {{{
function! FileName()
   return empty(expand('%:t')) ? 'no name' : expand('%:t')
endfunction
" }}}
" TabName() {{{
function! s:pad(word, n)
   let padding = ''
   for i in range(a:n - len(a:word))
      let padding .= ' '
   endfor
   return a:word . padding
endfunction

function! TabName()
   let fname = empty(expand('%:t')) ? 'no name' : expand('%:t')
   let length = len(fname)

   for n in range(tabpagenr('$'))
      for i in tabpagebuflist(n + 1)
         try
            let curlen = len(split(bufname(i), g:path_separator)[-1])
         catch
            let curlen = 0
         endtry
         if curlen > length
            let length = curlen
         endif
      endfor
   endfor
   return s:pad(fname, length)
endfunction
" }}}
" TabNextName() {{{
function! s:strip(name)
   if empty(a:name)
      return "no name"
   endif
   return split(a:name, g:path_separator)[-1]
endfunction

function! TabNextName() abort
   let s:bname = { x -> bufname(tabpagebuflist(x)[0]) }
   let name_1 = s:bname(tabpagenr() + 1)
   let name_2 = s:bname(1)

   if tabpagenr('$') == 1
      return ''
   endif
   if empty(name_1) && tabpagenr() == tabpagenr('$')
      return s:strip(name_2)
   elseif empty(name_1) 
      return 'no name'
   endif
   return s:strip(name_1)
endfunction
" }}}
" TabNumbers() {{{
function! TabNumbers()
   let s = ''
   for i in range(tabpagenr('$'))
      let n = i + 1

      if n == tabpagenr()
         let s .= '%#SteamLineTabCurrent#'
      else
         let s .= '%#SteamLineTabNumber#'
      endif
      let s .= '%' . n . 'T'
      let s .= n > tabpagenr() + 1 ? '%#SteamLineTabSeparator#|%#SteamLineTabNumber#' : ''
      let s .= ' ' . n
      if i != tabpagenr('$') - 1 
         let s .= ' '
      endif
      let s .= n < tabpagenr() - 1 ? '%#SteamLineTabSeparator#|' : ''
   endfor
   let s .= '%T'

   return s
endfunction
" }}}
" Mode() {{{
function! Mode()
   let mode_map = {
   \  "n": "NORMAL",
   \  "i": "INSERT",
   \  "v": "VISUAL",
   \  "V": "V-LINE",
   \  "s": "SELECT",
   \  "S": "S-LINE",
   \  "\<C-s>": "S-BLOCK",
   \  "\<C-v>": "V-BLOCK",
   \  "t": "TERMINAL",
   \  "R": "REPLACE",
   \  "c": "COMMAND"
   \}
   if has_key(mode_map, mode())
      return mode_map[mode()]
   endif
   return mode()
endfunction
" }}}
" ModalColor() {{{
function! s:mode_is(list)
   for i in a:list
      if i == mode()
         return v:true
      endif
   endfor
   return v:false
endfunction

function! ModalColor()
   if s:mode_is(["i", "R"])
      return '%#SteamLineModalColorInsert#'
   elseif s:mode_is(["v", "V", "\<C-v>", "s", "S", "\<C-s>"])
      return '%#SteamLineModalColorVisual#' 
   endif
   return '%#SteamLineModalColorNormal#'
endfunction
" }}}
" Filetype() {{{
function! FileType()
   return strlen(&filetype) > 0 ? &filetype : 'text'
endfunction
" }}}
" }}}


hi! SteamLineModalColorNormal ctermfg=232 ctermbg=226
hi! SteamLineModalColorInsert ctermfg=232 ctermbg=105
hi! SteamLineModalColorVisual ctermfg=232 ctermbg=154
hi! SteamLineSection2 ctermfg=232 ctermbg=226 cterm=reverse
hi! SteamLineSection3 ctermfg=246 ctermbg=236
hi! SteamLineSection4 ctermfg=236 ctermbg=234

hi! SteamLineTabCurrent ctermfg=246 ctermbg=234
hi! SteamLineTabNumber ctermfg=232 ctermbg=240
hi! link SteamLineTabSeparator SteamLineTabNumber


function! steamline#tabline()
   return "%#SteamLineModalColorNormal# %{TabName()} " . TabNumbers() . (empty(TabNextName()) ? "": " %#SteamLineSection3# ") ."%{TabNextName()} %#SteamLineSection4# %= %#SteamLineSection3#%999X X %#SteamLineModalColorNormal# close "
endfunction

set tabline=%!steamline#tabline()

function! steamline#statusline()
   return ModalColor() . ' %{Mode()} %#SteamLineSection2# %{empty(Modifiable()) ? "" : Modifiable() . " | "}%.20{FileName()} %{empty(ModFlag()) ? "":"| ". ModFlag()} %#SteamLineSection3# %{SynName()} %#SteamLineSection4# %= %#SteamLineSection3# %{FileType()} %#SteamLineSection2# %c:%l ' . ModalColor() . ' %{CharCount()} | words %{WordCount()} '
endfunction

set statusline=%!steamline#statusline()
