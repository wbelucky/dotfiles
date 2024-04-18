---@type LazySpec
local spec = {
  "ruifm/gitlinker.nvim",
  keys = {
    { "<leader>gy", [[<cmd>lua require"gitlinker".get_buf_range_url("n")<cr>]], mode = "n", desc = "Gitlinker Yank" },
    { "<leader>gy", [[<cmd>lua require"gitlinker".get_buf_range_url("v")<cr>]], mode = "v", desc = "Gitlinker Yank" },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gitlinker").setup { mappings = nil }
  end,
}

return spec
