---@type LazySpec
local spec = {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint" },
    },
  },
}
return spec
