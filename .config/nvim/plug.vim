call plug#begin(stdpath('data') . '/plugged')

if has('nvim')
  " Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'onsails/lspkind-nvim'
  Plug 'ruifm/gitlinker.nvim'
  Plug 'buoto/gotests-vim'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'tpope/vim-surround'
  Plug 'svrana/neosolarized.nvim'
  Plug 'tjdevries/colorbuddy.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'b0o/schemastore.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'makerj/vim-pdf'
  Plug 'voldikss/vim-translator'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug 'windwp/nvim-ts-autotag'
  Plug 'nvim-telescope/telescope-file-browser.nvim'
endif

call plug#end()
