---@type LazySpec
local spec = {
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  { "tpope/vim-surround", event = "VeryLazy" },
  { "vim-denops/denops.vim" },
  { "buoto/gotests-vim", ft = "go" },
  { "dstein64/vim-startuptime", event = "VeryLazy" },
  { "wbelucky/md-link-title.vim", dev = true },
}

return spec
