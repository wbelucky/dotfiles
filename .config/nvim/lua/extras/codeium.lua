---@type LazySpec
local spec = {
  { import = "lazyvim.plugins.extras.coding.codeium" },
  {
    "Exafunction/codeium.nvim",
    opts = {
      enable_chat = true,
      detect_proxy = true,
    },
  },
}
return spec
