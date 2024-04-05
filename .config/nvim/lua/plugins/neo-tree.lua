---@type LazySpec
local spec = {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>t",
      function()
        require("neo-tree.command").execute { toggle = true, dir = vim.fn.expand "%:p:h" }
      end,
      desc = "NeoTree Around File",
    },
    { "<leader>e", false }, -- Explorer Neo-tree (Root Dir)
  },
  opts = {
    window = {
      mappings = {
        ["h"] = "navigate_up",
        ["l"] = "open",
        ["gh"] = "focus_preview",
      },
    },
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}

return spec
