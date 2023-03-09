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
    'nvim-telescope/telescope.nvim',
    module = { 'telescope' },
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim', opt = true },
      { 'nvim-telescope/telescope-ghq.nvim', opt = true },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    wants = { 'telescope-file-browser.nvim', 'telescope-ghq.nvim', 'telescope-ui-select.nvim' },
    setup = function() require('plugins.telescope_rc').setup() end,
    config = function() require('plugins.telescope_rc').config() end,
  }
  -- packer
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }


  use {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre" },
    requires = {
      { 'williamboman/mason-lspconfig.nvim', module = 'mason-lspconfig' },
      { 'williamboman/mason.nvim', module = 'mason' },
    },
    wants = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "cmp-nvim-lsp",
    },
    config = function() require('plugins.lspconfig').config() end,
  }

  use 'jose-elias-alvarez/typescript.nvim'
  use 'onsails/lspkind-nvim'

  use {
    'jose-elias-alvarez/null-ls.nvim',
    opt = true,
    config = function() require('plugins.null-ls').config() end,
    ft = { 'typescript', 'typescriptreact', 'golang' }
  }

  use(require("plugins.cmp"))

  use {
    'ruifm/gitlinker.nvim',
    config = function()
      require("gitlinker").setup()
    end
  }

  use(require("plugins.gitsigns"))
  -- use 'pwntester/octo.nvim'

  use 'tpope/vim-surround'
  -- use {
  --   'svrana/neosolarized.nvim',
  --   requires = { 'tjdevries/colorbuddy.nvim' }
  -- }
  use {
    'folke/tokyonight.nvim',
    config = function() vim.cmd [[colorscheme tokyonight]] end
  }


  use { 'buoto/gotests-vim', opt = true, ft = 'go' }


  use {
    'akinsho/flutter-tools.nvim',
    opt = true,
    ft = 'dart',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('plugins.flutter-tools').config() end,
  }
  use {
    'windwp/nvim-ts-autotag',
    requires = { 'nvim-treesitter/nvim-treesitter' }
  }

  use 'b0o/schemastore.nvim'

  use 'makerj/vim-pdf'
  use 'voldikss/vim-translator'
  use 'kyazdani42/nvim-web-devicons'
  use 'dstein64/vim-startuptime'
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
