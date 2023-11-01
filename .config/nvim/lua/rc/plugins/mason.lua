---@type LazySpec
local spec = {
  "williamboman/mason.nvim",
  cmd = "Mason",
  build = ":MasonUpdate",
  config = function()
    require("mason").setup()
  end,
}

return spec
