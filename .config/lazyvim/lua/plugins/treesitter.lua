---@type LazySpec
local spec = {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    incremental_selection = {
      keymaps = {
        init_selection = "<C-l>",
        node_incremental = "<C-l>",
        node_decremental = "<bs>",
      },
    },
  },
}

return spec
