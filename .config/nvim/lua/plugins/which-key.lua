---@type LazySpec
local spec = {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.defaults["<leader>m"] = { name = "+my" }
    opts.defaults["<leader>w"] = nil
    return opts
  end,
}

return spec
