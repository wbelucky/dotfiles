---@type LazySpec
local spec = {
  {
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
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    "ruifm/gitlinker.nvim",
    keys = { { "<leader>Gy", mode = "n" }, { "<leader>Gy", mode = "v" } },
    config = function()
      require("gitlinker").setup()
    end,
  },
  { "tpope/vim-surround" },
  { "vim-denops/denops.vim" },
  { "buoto/gotests-vim", ft = "go" },
  { "dstein64/vim-startuptime" },
}

return spec
