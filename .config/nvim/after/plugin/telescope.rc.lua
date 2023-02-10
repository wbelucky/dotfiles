local status, telescope = pcall(require, "telescope")

if (not status) then return end

local builtin = require("telescope.builtin")
local actions = require('telescope.actions')
local wb_actions = require('wbelucky.telescope_actions')
local fb_actions = require("telescope._extensions.file_browser.actions")

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["l"] = actions.select_default,
        ["s"] = actions.select_vertical,
        ["t"] = actions.select_tab,
      },
    }
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        n = {
          ["a"] = fb_actions.create,
          ["cd"] = fb_actions.change_cwd,
          ["h"] = fb_actions.goto_parent_dir,
          ["t"] = actions.select_tab,
          ["z"] = wb_actions.find_files_from_fb,
          ["/"] = function()
            vim.cmd('startinsert')
          end,
        },
        i = {
          ["<CR>"] = wb_actions.select_default,
        }
      },
      -- attach_mappings = attach_mappings,
    }
  }
}

telescope.load_extension("file_browser")

vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<space>d', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

vim.keymap.set(
  "n",
  "<leader>t",
  function()
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
      default_selection_index = 2,
      cwd = vim.fn.expand('%:p:h'),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      previewer = false,
      initial_mode = "normal",
      layout_config = { height = 40 }
    })
  end,
  {}
)
