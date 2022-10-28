if exists("g:loaded_bigquery_vim")
  finish
endif
let g:loaded_bigquery_vim = 1

command! -range BQExecute call bigquery_vim#ExecuteQuery(<line1>, <line2>)
