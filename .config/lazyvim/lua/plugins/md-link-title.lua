---@type LazySpec
local spec = {
  "wbelucky/md-link-title.vim",
  lazy = false,
  dev = true,
  ft = "markdown",
  init = function(spec)
    if spec.dev then
      vim.g["denops#debug"] = 1
    end
  end,
  dependencies = { "vim-denops/denops.vim" },
}

return spec
