
" !autoflake -i --remove-all-unused-imports "%"


function! s:remove_all_unused_imports() abort
  let tmpfile = tempname()
  call writefile(getline(1, '$'), tmpfile)
  let cmd = 'autoflake -i --remove-all-unused-imports ' . tmpfile
  echo system('sh -c ' . "'" . cmd . "'")
  %d
  execute 'read ' . tmpfile
  1d
  call delete(tmpfile)
endfunction


command! Autoflake :call s:remove_all_unused_imports()
