---@type LazySpec
local spec = {
  "zk-org/zk-nvim",
  keys = {
    {
      "<leader>md",
      [[<cmd>ZkNew { group = "journal", dir = "journal" }<cr>]],
      desc = "Open Diary",
    },
  },
  config = function()
    require("zk").setup {
      -- See Setup section below
    }
  end,
}

return spec
