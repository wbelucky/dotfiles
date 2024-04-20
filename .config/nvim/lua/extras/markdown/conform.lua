---@type LazySpec
local spec = {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft.markdown = { "markdownlint" }
    return opts
  end,
}
return spec
