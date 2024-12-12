---@type LazySpec
local spec = {
  "wbelucky/hey.vim",
  dev = true,
  cmd = { "Hey", "HeyEdit", "HeyAbort" },
  dependencies = { "vim-denops/denops.vim" },
}

return spec
