---@type LazySpec
local spec = {
  { import = "lazyvim.plugins.extras.coding.codeium", enabled = false },
  {
    "Exafunction/codeium.nvim",
    enabled = false,
    opts = {
      enable_chat = true,
      detect_proxy = true,
    },
  },
}
return spec
