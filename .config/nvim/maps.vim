nnoremap k gk
nnoremap j gj

noremap <silent> <C-S> :update<cR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

nnoremap <ESC><ESC> :nohlsearch<CR>

" :TermでTerminalが新しいwindowで開く
if has('nvim')
  command! -nargs=* Term split | terminal <args>
  command! -nargs=* Termv vsplit | terminal <args>
endif

if has('nvim')
  augroup vimrc_term
    autocmd!
    autocmd WinEnter term://* nohlsearch
    autocmd WinEnter term://* startinsert

    autocmd TermOpen * tnoremap <buffer> <C-W>h <C-\><C-n><C-w>h
    autocmd TermOpen * tnoremap <buffer> <C-W>j <C-\><C-n><C-w>j
    autocmd TermOpen * tnoremap <buffer> <C-W>k <C-\><C-n><C-w>k
    autocmd TermOpen * tnoremap <buffer> <C-W>l <C-\><C-n><C-w>l
    autocmd TermOpen * tnoremap <buffer> <Esc><Esc> <C-\><C-n>
  augroup END
endif
