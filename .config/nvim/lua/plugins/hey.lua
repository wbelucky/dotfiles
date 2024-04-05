---@type LazySpec
local spec = {
  "wbelucky/hey.vim",
  lazy = false,
  branch = "refactor",
  cmd = { "Hey", "HeyEdit", "HeyAbort" },
  dependencies = { "vim-denops/denops.vim" },
}

return spec
