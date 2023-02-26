local ensure_packer = function()
  local fn = vim.fn
  local cmd = vim.cmd
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    cmd [[packadd packer.nvim]]
    return true
  end
  return false
end


local packer = nil
local function init()
  local packer_bootstrap = ensure_packer()
  if packer == nil then
    packer = require 'packer'
    packer.init {}
  end
  packer.reset()
  local use = packer.use

  use {
    "wbthomason/packer.nvim",
    opt = true,
  }
  use 'nvim-lua/plenary.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'nvim-telescope/telescope-file-browser.nvim'


  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'onsails/lspkind-nvim'

  use 'jose-elias-alvarez/null-ls.nvim'

  use 'hrsh7th/vim-vsnip'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-vsnip'

  use 'tpope/vim-fugitive'
  use 'ruifm/gitlinker.nvim'
  use 'pwntester/octo.nvim'

  use 'tpope/vim-surround'
  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' }
  }


  use { 'buoto/gotests-vim', opt = true, ft = 'go' }

  use 'jose-elias-alvarez/typescript.nvim'
  use 'windwp/nvim-ts-autotag'

  use 'b0o/schemastore.nvim'

  use 'makerj/vim-pdf'
  use 'voldikss/vim-translator'
  use 'kyazdani42/nvim-web-devicons'
  if packer_bootstrap then
    packer.sync()
  end
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
