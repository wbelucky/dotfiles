local spec = {
  ---@type LazySpec
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = { { "nvim-telescope/telescope-ghq.nvim" } },
  keys = {
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status { cwd = vim.fn.expand "%:p:h" }
      end,
      desc = "Status",
    },
    {
      "<leader>gc",
      function()
        require("telescope.builtin").git_commits { cwd = vim.fn.expand "%:p:h" }
      end,
      desc = "Commits",
    },
      -- add a keymap to browse plugin files
      -- stylua: ignore
    { "<leader>p", LazyVim.telescope("files"), desc = "Find Files" },
    { "<leader><space>", false },
    {
      "<leader><C-p>",
      function()
        require("telescope.builtin").find_files { cwd = vim.fn.expand "%:p:h" }
      end,
      desc = "Find Files Around File",
    },
    {
      "<leader>s<C-g>",
      function()
        require("telescope.builtin").live_grep { cwd = vim.fn.expand "%:p:h" }
      end,
      desc = "Live Grep Around File",
    },
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files { cwd = require("lazy.core.config").options.root }
      end,
      desc = "Find Plugin File",
    },
    {
      "<leader>gq",
      function()
        local telescope = require "telescope"
        telescope.load_extension "ghq"
        telescope.extensions.ghq.list()
      end,
      desc = "List Git Repositories under GH[Q]",
    },
    {
      "<leader>xn",
      function()
        local telescope = require "telescope"
        telescope.load_extension "notify"
        telescope.extensions.notify.notify()
      end,
      desc = "Telescope notify",
    },
  },
  -- change some options
  opts = {
    defaults = vim.tbl_extend(
      "force",
      require("telescope.themes").get_ivy(), -- or get_cursor, get_ivy
      {
        --- other `default` options go here
      }
    ),
    pickers = {
      git_status = {
        git_icons = {
          added = "🏁",
          changed = "🚧",
          copied = "💫",
          deleted = "🔥",
          renamed = "🚚",
          unmerged = "🔀",
          untracked = "✨",
        },
      },
    },
    extensions = {
      ghq = {
        -- TODO: こうしたい
        -- ref: https://github.com/nvim-telescope/telescope-ghq.nvim/blob/dc1022f91100ca06c9c7bd645f08e2bf985ad283/lua/telescope/_extensions/ghq_builtin.lua#L113-L134
        -- mappings = {
        --   i = {
        --     ["<CR>"] = wb_actions.ghq_select_default,
        --   }
        -- }
      },
    },
  },
}

return spec
