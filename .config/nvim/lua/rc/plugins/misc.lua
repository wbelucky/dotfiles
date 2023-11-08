---@type LazySpec
local spec = {
  {
    "windwp/nvim-ts-autotag",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  { "tpope/vim-surround", event = "VeryLazy" },
  { "buoto/gotests-vim", ft = "go" },
  { "dstein64/vim-startuptime", event = "VeryLazy" },
}

return spec
