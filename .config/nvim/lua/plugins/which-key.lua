---@type LazySpec
local spec = {
  "folke/which-key.nvim",
  opts = {
    defaults = {
      ["<leader>m"] = { name = "+my" },
    },
  },
}

return spec
