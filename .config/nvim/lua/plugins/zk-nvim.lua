---@type LazySpec
local spec = {
  "zk-org/zk-nvim",
  event = "LazyFile",
  keys = {
    {
      "<leader>md",
      [[<cmd>ZkNew { group = "journal", dir = "journal" }<cr>]],
      desc = "Open Diary",
    },
    {
      "<leader>my",
      function()
        require("zk.commands").get "ZkNewFromContentSelection" {
          group = "posts",
          dir = "posts",
          title = vim.fn.input "Title: ",
        }
      end,
      -- [[<cmd>'<,'>ZkNewFromContentSelection { group = "posts", dir = "posts", title= }<cr>]],
      desc = "Yank and create a new zk post",
      mode = "v",
    },
    {
      "<leader>mp",
      function()
        require("zk.commands").get "ZkNewFromContentSelection" {
          group = "private",
          dir = "private",
          title = vim.fn.input "Title: ",
        }
      end,
      -- [[<cmd>'<,'>ZkNewFromContentSelection { group = "posts", dir = "posts", title= }<cr>]],
      desc = "Yank and create a [P]rivate zk post",
      mode = "v",
    },
    {
      "<leader>mt",
      "<cmd>ZkTags<cr>",
      desc = "ZkTags",
      mode = "n",
    },
  },
  config = function()
    require("zk").setup {
      picker = "telescope",
      -- See Setup section below
    }
  end,
}

return spec
