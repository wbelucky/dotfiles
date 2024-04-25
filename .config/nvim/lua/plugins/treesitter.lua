---@type LazySpec
local spec = {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    incremental_selection = {
      keymaps = {
        init_selection = "<tab>",
        node_incremental = "<tab>",
        node_decremental = "<bs>",
      },
    },
  },
}

return spec
