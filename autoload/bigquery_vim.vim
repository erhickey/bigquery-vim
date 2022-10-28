let g:bq_command = 'bq'
let g:bq_params = ['query', '--nouse_legacy_sql']
let g:bq_bufnr = -1

function! bigquery_vim#ExecuteQuery(line1, line2)
  let lines = map(getline(a:line1, a:line2), 's:ReplaceQuotes(s:StripComments(v:val))')
  let query = s:StripCommentBlocks(join(lines, ' '))
  call s:RunAndShow(s:BuildCommand(query))
endfunction

function! s:StripComments(s)
  return matchstr(a:s, '\zs.\{-}\ze\(#\|--\|$\)')
endfunction

function! s:StripCommentBlocks(s)
  return substitute(a:s, '\/\*.\{-}\*\/', '', 'g')
endfunction

function! s:ReplaceQuotes(s)
  return substitute(a:s, "\'", '"', 'g')
endfunction

function! s:BuildCommand(query)
  return g:bq_command . ' ' . join(g:bq_params, ' ') . " '" . a:query . "'"
endfunction

function! s:RunAndShow(command)
  call s:OpenWindow(s:GetScratchBuffer())
  silent execute '1,$d'
  silent execute 'read !' . a:command
  silent execute 'norm! gg'
  silent execute 'wincmd p'
endfunction

function! s:GetScratchBuffer()
  if !bufexists(g:bq_bufnr)
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    let g:bq_bufnr = bufnr()
  endif

  return g:bq_bufnr
endfunction

function! s:OpenWindow(bufnr)
  let winnr = bufwinnr(a:bufnr)
  silent execute winnr . 'wincmd w'
endfunction
