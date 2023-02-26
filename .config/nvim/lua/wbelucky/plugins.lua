-- ref: https://qiita.com/delphinus/items/8160d884d415d7425fcc#43-packernvim-%E8%87%AA%E4%BD%93%E3%82%92%E9%81%85%E5%BB%B6%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BF%E3%81%99%E3%82%8B
-- ref: https://github.com/wbthomason/dotfiles/blob/063850b4957a55c065f795722163efc88ffb1b42/neovim/.config/nvim/lua/plugins.lua
local packer = nil
local function init()
  if packer == nil then
    local cmd = vim.cmd
    cmd [[packadd packer.nvim]]
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
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
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
  use {
    'windwp/nvim-ts-autotag',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use 'b0o/schemastore.nvim'

  use 'makerj/vim-pdf'
  use 'voldikss/vim-translator'
  use 'kyazdani42/nvim-web-devicons'
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
