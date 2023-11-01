---@type LazySpec
local spec = {
  {
    "ojroques/nvim-osc52",
    event = "TextYankPost",
    keys = {
      {
        "<leader>c",
        function()
          require("osc52").copy_operator()
        end,
        mode = "n",
        { expr = true },
      },

      {
        "<leader>cc",
        "<leader>c_",
        mode = "n",
        { remap = true },
      },
      {
        "<leader>c",
        function()
          require("osc52").copy_visual()
        end,
        mode = "x",
      },
    },
    config = function()
      require("osc52").setup {}
      local function copy()
        if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
          require("osc52").copy_register "+"
        end
      end

      vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "ruifm/gitlinker.nvim",
    keys = { { "<leader>Gy", mode = "n" }, { "<leader>Gy", mode = "v" } },
    config = function()
      require("gitlinker").setup()
    end,
  },
  { "tpope/vim-surround", event = "VeryLazy" },
  { "vim-denops/denops.vim", event = "VeryLazy" },
  { "buoto/gotests-vim", ft = "go" },
  { "dstein64/vim-startuptime", event = "VeryLazy" },
}

return spec
