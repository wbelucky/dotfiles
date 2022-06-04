
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :<C-u>call CocAction('doHover')<cr>
nmap <silent> <C-p> :<C-u>CocList<cr>
nmap <silent> <F2> <Plug>(coc-rename)
