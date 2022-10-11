" ref: https://zenn.dev/skanehira/articles/2021-12-04-vim-markdown-fold-details
setlocal foldmethod=marker
setlocal foldmarker=<details>,</details>
" TODO: fold-foldtext
setlocal foldtext=v:folddashes.substitute(getline(v:foldstart+1),'<summary>\\\|</summary>','','g')

function! s:put_markdown_link() abort
  let line = getline(".")
  let edited = substitute(line, '\v(.*)\s+(\S+)$', '[\1](\2)', "")
  call setline(".", edited)
endfunction

function! s:on_paste_url_to_md() abort
  let url = getreg("+")
  call append(line("."), "[](" . url . ")")
endfunction

function! s:paste_recent_screenshot(name) abort
  let target = expand('%:p:h') . "/" . a:name
  let bashCmd = 'mv "$(ls -td $HOME/Pictures/* | head -n 1)" ' . target
  echo system('bash -c ' . "'" . bashCmd . "'")
  call append(line("."), "![](" . a:name . ")")
endfunction


function! s:paste_recent_download(name) abort
  let target = expand('%:p:h') . "/" . a:name
  let bashCmd = 'mv "$(ls -td $HOME/Downloads/* | head -n 1)" ' . target
  echo system('bash -c ' . "'" . bashCmd . "'")
  call append(line("."), "![](" . a:name . ")")
endfunction

function! s:date_format() abort
  let res = strftime("%Y-%m-%d")
  call append(line("."), "# " . res)
  normal dd
endfunction


command! Link :call s:put_markdown_link()
command! Pl :call s:on_paste_url_to_md()
command! -nargs=1 PasteSS :call s:paste_recent_screenshot(<f-args>)
command! -nargs=1 PasteDL :call s:paste_recent_download(<f-args>)
command! Date :call s:date_format()

