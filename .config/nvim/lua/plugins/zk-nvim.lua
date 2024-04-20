---@type LazySpec
local spec = {
  "wbelucky/zk-nvim",
  dev = true,
  event = "LazyFile",
  keys = {
    {
      "<leader>md",
      function()
        require("zk.commands").get "ZkNew" {
          group = "journal",
          dir = "journal",
        }
      end,
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
      desc = "Yank and create a [P]rivate zk post",
      mode = "v",
    },
    {
      "<leader>mt",
      function()
        require("zk.commands").get "ZkTags" {}
      end,
      desc = "ZkTags",
      mode = "n",
    },
  },
  config = function()
    require("zk").setup {
      picker = "telescope",
      cd_on_edit = true,
    }
  end,
}

return spec
