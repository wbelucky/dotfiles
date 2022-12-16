autocmd!
scriptencoding utf-8


" Don't redraw while executing macros (good performance config)
set lazyredraw
set termguicolors


set shell=fish

" editor view
set number relativenumber
syntax enable
set nowrap "no wrap lines
set cursorline

" file
set fileencodings=utf-8,sjis
set encoding=utf-8
set nobackup
set noswapfile
set autoread " autoread if the file edited out of the vim.
set hidden " can open another file if the buffer is not saved


" space by tab
set tabstop=2
set expandtab "insert [softtabstop] spaces by tab key
set softtabstop=-1 " spaces to insert or delete by tab or delete, -1 means same with tabstop

" replace special charactor
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" indent

set smarttab "insert indent with tab key at the begining of line
set shiftwidth=0 "自動インデントでずれる値 0 means same as tabstop
set autoindent "indent following previous line
" set smartindent "indent by line break
filetype plugin indent on

" search
set ignorecase "大文字や小文字の区別なく検索
set smartcase "大文字が含まれていた場合は区別する
set hlsearch "add highlight to search result
set incsearch "search string before confirm
set inccommand=split

" status and command line
set laststatus=2 "print some status
set cmdheight=1
set wildmenu "print candidates of :command line
set infercase "補完時に大文字小文字を区別しない

" clipboards
set clipboard=unnamedplus
" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm

" Turn off paste mode when leaivng inser
autocmd InsertLeave * set nopaste

if system('uname -a | grep -i microsoft') != ''
  let g:netrw_browsex_viewer="cmd.exe /C start" 
  let g:clipboard = {
        \ 'name': 'win32yank',
        \ 'copy': {
        \    '+': 'win32yank.exe -i --crlf',
        \    '*': 'win32yank.exe -i --crlf',
        \  },
        \ 'paste': {
        \    '+': 'win32yank.exe -o --lf',
        \    '*': 'win32yank.exe -o --lf',
        \ },
        \ 'cache_enabled': 1,
        \ }
endif

" filetypes
au BufNewFile,BufRead *.fish setl filetype=fish
au BufNewFile,BufRead *.tsx setl filetype=typescriptreact
au BufNewFile,BufRead *.md setl filetype=markdown
au BufNewFile,BufRead *.mdx setl filetype=markdown


runtime ./maps.vim
runtime ./plug.vim

