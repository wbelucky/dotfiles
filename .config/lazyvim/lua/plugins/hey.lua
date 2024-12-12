---@type LazySpec
local spec = {
  "wbelucky/hey.vim",
  dev = true,
  lazy = false,
  branch = "refactor",
  cmd = { "Hey", "HeyEdit", "HeyAbort" },
  dependencies = { "vim-denops/denops.vim" },
  init = function(spec)
    if spec.dev then
      vim.g["denops#debug"] = 1
    end
  end,
}

return spec
