" TODO: decide whether to globalise / internalise default items
let g:steamline_default_filetype = 'plain'
let g:steamline_title_ignored_filetypes = ['help', 'nerdtree']
let g:steamline_padded_tab_titles = v:false
let g:steamline_tab_separator = '|'
let g:steamline_empty_filename = '[no name]'

let g:steamline_highlight_names = {
   \ 'tab_current': 'SteamlineTabCurrent',
   \ 'tab_normal': 'SteamlineTabNumber',
   \ 'tab_separator': 'SteamlineTabSeparator',
   \ 'insert_mode': 'SteamlineModalColourInsert',
   \ 'visual_mode': 'SteamlineModalColourVisual',
   \ 'normal_mode': 'SteamlineModalColourNormal',
   \ 'command_mode': 'StemalineModalColourCommand',
   \ 'replace_mode': 'StemalineModalColourReplace',
   \ }

function! s:get_highlight(name)
   return '%#' . get(g:steamline_highlight_names, a:name, 'Error') . '#'
endfunction

let g:steamline_modal_colours = {
   \ 'i': s:get_highlight('insert_mode'),
   \ 'R': s:get_highlight('replace_mode'),
   \ "v|V|\<c-v>|s|S|\<c-s>": s:get_highlight('visual_mode'),
   \ 't|c': s:get_highlight('command_mode'),
   \ }

let g:steamline_mode_map = {
   \ 'n': 'NORMAL',
   \ 'i': 'INSERT',
   \ 'v': 'VISUAL',
   \ 'V': 'V-LINE',
   \ 's': 'SELECT',
   \ 'S': 'S-LINE',
   \ "\<c-s>": 'S-BLOCK',
   \ "\<c-v>": 'V-BLOCK',
   \ 't': 'TERMINAL',
   \ 'R': 'REPLACE',
   \ 'c': 'COMMAND'
   \}

function! steamline#modifiable()
   return !&modifiable || &readonly ? "\ue0a2" : ''
endfunction

function! steamline#modified()
   return &modified ? "\u25cf" : ''
endfunction

function! steamline#word_count()
   let word_stats = wordcount()
   let word_count = get(word_stats, 'words')

   return get(word_stats, 'visual_words', word_count)
endfunction

function! steamline#char_count()
   return get(wordcount(), 'chars')
endfunction

function! steamline#filename()
   let filename = expand('%:t')
   return empty(filename) ? g:steamline_empty_filename : filename
endfunction

function! s:get_tab_title(tabnumber, ignored_filetypes = g:steamline_title_ignored_filetypes)
   let buffers = tabpagebuflist(a:tabnumber)

   if len(buffers) == 1
      return fnamemodify(bufname(buffers[0]), ':t')
   endif

   for buffer in buffers
      if !s:has_item(a:ignored_filetypes, getbufvar(buffer, '&filetype'))
         return fnamemodify(bufname(buffer), ':t')
      endif
   endfor
endfunction

function! s:pad(word, char, width, left=v:true)
   let padding = repeat(a:char, a:width - len(a:word))
   return a:left ? padding . a:word : a:word . padding
endfunction

function! steamline#tab_name()
   let filename = steamline#filename()
   let max_length = 0

   if g:steamline_padded_tab_titles
      for tabnumber in range(1, tabpagenr('$'))
         let length = len(s:get_tab_title(tabnumber))

         if length > max_length
            let max_length = length
         endif
      endfor
   endif

   return s:pad(filename, ' ', max_length, v:false)
endfunction

function! steamline#tab_next_name()
   let current_tabnumber = tabpagenr()
   let last_tabnumber = tabpagenr('$')
   let next_tab_bufname = s:get_tab_title(current_tabnumber + 1)

   if last_tabnumber == 1
      return ''
   endif

   if current_tabnumber == last_tabnumber
      return s:get_tab_title(1)

   elseif empty(next_tab_bufname) 
      return g:steamline_empty_filename
   endif

   return next_tab_bufname
endfunction

function! steamline#tab_numbers()
   let tab_string = ''
   let current_tabnumber = tabpagenr()
   let tab_count = tabpagenr('$')
   let tab_current = s:get_highlight('tab_current')
   let tab_normal = s:get_highlight('tab_normal')
   let tab_separator = s:get_highlight('tab_separator')

   for tabnumber in range(1, tab_count)
      let tab_string .= (tabnumber == current_tabnumber) ? tab_current : tab_normal
      let tab_string .= '%' . tabnumber . 'T'
      let tab_string .= (tabnumber > current_tabnumber + 1) ? tab_separator . '|' . tab_normal . ' ' . tabnumber : ' ' . tabnumber

      if tabnumber != tab_count 
         let tab_string .= ' '
      endif

      let tab_string .= (tabnumber < current_tabnumber - 1) ? tab_separator . '|' : ''
   endfor

   return tab_string . '%T'
endfunction

function! steamline#mode()
   return get(g:steamline_mode_map, mode(), mode())
endfunction

function! s:has_item(list, string)
   return index(a:list, a:string) >= 0
endfunction

function! steamline#modal_colour()
   for [key, value] in items(g:steamline_modal_colours)
      let current_mode = mode()
      let mapped_modes = split(key, "|")

      if s:has_item(mapped_modes, current_mode)
         return value
      endif
   endfor

   return s:get_highlight('normal_mode')
endfunction

function! Steamlinetprogress()
   let progress = float2nr((line('.') * 100.0) / line('$'))
   return (progress == 0) ? 'Top' : (progress == 100) ? 'Bot' : progress . '%'
endfunction

function! steamline#filetype()
   return empty(&filetype) ? g:steamline_default_filetype : &filetype
endfunction

function! steamline#tabline()
   return '%{%steamline#modal_colour()%} %{steamline#tab_name()} %{%steamline#tab_numbers()%}' . (empty(steamline#tab_next_name()) ? '' : ' %#SteamLineSection3# ') . '%{steamline#tab_next_name()} %#SteamLineSection4#'
endfunction

function! steamline#statusline()
   redrawtabline
   return '%{%steamline#modal_colour()%} %{steamline#mode()} %#SteamLineSection2# %.20{steamline#filename()}' . (empty(steamline#modifiable()) && empty(steamline#modified()) ? '' : ' %{steamline#modifiable()}%{steamline#modified()}') . ' %#SteamLineSection4# %= %#SteamLineSection3# %{steamline#filetype()} %#SteamLineSection2# %c:%l ' . steamline#modal_colour() . ' %{steamline#char_count()} | words %{steamline#word_count()} '
endfunction

function! steamline#inactive_statusline()
   return ' %{steamline#filename()} %{steamline#modifiable()}%{steamline#modified()} %=%{steamline#filetype()} '
endfunction
