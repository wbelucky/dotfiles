-- ref: https://qiita.com/delphinus/items/8160d884d415d7425fcc#43-packernvim-%E8%87%AA%E4%BD%93%E3%82%92%E9%81%85%E5%BB%B6%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BF%E3%81%99%E3%82%8B
-- ref: https://github.com/wbthomason/dotfiles/blob/063850b4957a55c065f795722163efc88ffb1b42/neovim/.config/nvim/lua/plugins.lua
local packer = nil
local function init()
  if packer == nil then
    local cmd = vim.cmd
    cmd [[packadd packer.nvim]]
    packer = require "packer"
    packer.init {}
  end
  packer.reset()
  local use = packer.use

  use {
    "wbthomason/packer.nvim",
    opt = true,
  }
  use "nvim-lua/plenary.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update { with_sync = true }
      ts_update()
    end,
  }

  use(require "wbelucky.lua_line")

  use {
    "nvim-telescope/telescope.nvim",
    module = { "telescope" },
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim", opt = true },
      { "nvim-telescope/telescope-ghq.nvim", opt = true },
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    wants = {
      "telescope-file-browser.nvim",
      "telescope-ghq.nvim",
      "telescope-ui-select.nvim",
    },
    setup = function()
      require("plugins.telescope_rc").setup()
    end,
    config = function()
      require("plugins.telescope_rc").config()
    end,
  }

  -- use({
  --   "jackMort/ChatGPT.nvim",
  --   -- opt = true,
  --   -- module = "chatgpt",
  --   config = function()
  --     require("chatgpt").setup({
  --       keymaps = {
  --         submit = "<C-t>"
  --       }
  --     })
  --   end,
  --   requires = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- })

  -- use {
  --   "wbelucky/hey.vim",
  --   branch = "refactor",
  --   requires = { "vim-denops/denops.vim" },
  -- }
  use { "vim-denops/denops.vim" }

  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  }

  -- use {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   module = "lsp_lines",
  -- }
  use {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    requires = {
      { "williamboman/mason-lspconfig.nvim", module = "mason-lspconfig" },
      { "williamboman/mason.nvim", module = "mason", run = ":MasonUpdate" },
      { "jay-babu/mason-null-ls.nvim", module = "mason-null-ls" },
      { "jose-elias-alvarez/null-ls.nvim", module = "null-ls" },
    },
    wants = {
      "mason.nvim",
      "mason-lspconfig.nvim",
      "cmp-nvim-lsp",
      "mason-null-ls.nvim",
      "null-ls.nvim",
    },
    config = function()
      require("plugins.lspconfig").config()
    end,
  }

  use "jose-elias-alvarez/typescript.nvim"
  use "onsails/lspkind-nvim"

  -- use {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = { "BufReadPre" },
  --   config = function()
  -- require("plugins.null-ls").config()
  --   end,
  --   -- ft = { 'typescript', 'typescriptreact', 'golang' }
  -- }

  use(require "plugins.cmp")

  use {
    "ruifm/gitlinker.nvim",
    opt = true,
    keys = { { "n", "gy" }, { "v", "gy" } },
    config = function()
      require("gitlinker").setup()
    end,
  }

  use(require "plugins.gitsigns")
  -- use 'pwntester/octo.nvim'

  use "tpope/vim-surround"
  -- use {
  --   'svrana/neosolarized.nvim',
  --   requires = { 'tjdevries/colorbuddy.nvim' }
  -- }
  use {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "day", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = false, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,

        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      }
      vim.cmd [[colorscheme tokyonight]]
    end,
  }

  use { "buoto/gotests-vim", opt = true, ft = "go" }

  use {
    "akinsho/flutter-tools.nvim",
    opt = true,
    ft = "dart",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.flutter-tools").config()
    end,
  }
  use {
    "mfussenegger/nvim-dap",
    opt = true,
    module = "dap",
  }

  use {
    "windwp/nvim-ts-autotag",
    requires = { "nvim-treesitter/nvim-treesitter" },
  }

  use "b0o/schemastore.nvim"

  use "makerj/vim-pdf"
  use "voldikss/vim-translator"
  use "kyazdani42/nvim-web-devicons"
  use "dstein64/vim-startuptime"
  use {
    "ojroques/nvim-osc52",
    config = function()
      require("osc52").setup {}
      vim.keymap.set("n", "<leader>c", require("osc52").copy_operator, { expr = true })
      vim.keymap.set("n", "<leader>cc", "<leader>c_", { remap = true })
      vim.keymap.set("x", "<leader>c", require("osc52").copy_visual)
      local function copy()
        if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
          require("osc52").copy_register "+"
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
  }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
