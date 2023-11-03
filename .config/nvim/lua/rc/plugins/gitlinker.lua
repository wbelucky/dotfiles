---@type LazySpec
local spec = {
  "ruifm/gitlinker.nvim",
  keys = { { "gy", mode = "n" }, { "gy", mode = "v" } },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gitlinker").setup { mappings = "gy" }
  end,
}

return spec
