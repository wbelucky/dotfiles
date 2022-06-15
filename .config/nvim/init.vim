autocmd!
scriptencoding utf-8



" Don't redraw while executing macros (good performance config)
set lazyredraw

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
" set

set smarttab "insert indent with tab at the begining of line
set shiftwidth=0 "自動インデントでずれる値 0 means same as tabstop
set autoindent "indent following previous line
" set smartindent "indent by line break
filetype plugin indent on

" search
set hlsearch "add highlight to search result
set incsearch "search string before confirm

" status and command line
set laststatus=2 "print some status
set cmdheight=1
set wildmenu "print candidates of :command line

" clipboards
set clipboard=unnamedplus
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
au BufNewFile,BufRead *.fish set filetype=fish
au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown


call plug#begin(stdpath('data') . '/plugged')

if has('nvim')
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'onsails/lspkind-nvim'
  Plug 'ruifm/gitlinker.nvim'
endif

call plug#end()

runtime ./maps.vim

