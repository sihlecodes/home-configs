set tabline=%!steamline#tabline()
set statusline=%!steamline#statusline()

function! s:force()
   set tabline=%!steamline#tabline()
   redrawtabline
endfunction

augroup steamline
   autocmd!
   autocmd CmdWinEnter,CmdWinLeave,InsertEnter,InsertLeave * call s:force()
   autocmd BufLeave,BufWinLeave,WinLeave * setlocal statusline=%!steamline#inactive_statusline()
   autocmd BufEnter,BufWinEnter,WinEnter * setlocal statusline=%!steamline#statusline()
augroup END
