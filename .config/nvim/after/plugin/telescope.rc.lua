local status, telescope = pcall(require, "telescope")

if (not status) then return end

local builtin = require("telescope.builtin")
local actions = require('telescope.actions')
local wb_actions = require('wbelucky.telescope_actions')
local fb_actions = require("telescope._extensions.file_browser.actions")
local themes = require('telescope.themes')

telescope.setup {
  defaults = {
    mappings = {
      n = {
        ["l"] = actions.select_default,
        ["s"] = actions.select_vertical,
        ["t"] = actions.select_tab,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      -- args of ripgrep. ref: .ripgreprc in $RIPGREP_CONFIT_PATH
      additional_args = function(_)
        return { "--hidden" }
      end
    }
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      select_buffer = true,
      mappings = {
        n = {
          ["a"] = fb_actions.create,
          ["cd"] = fb_actions.change_cwd,
          ["h"] = wb_actions.goto_parent_dir_with_select_cb,
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

local ivy = function(f, opt)
  return function()
    f(themes.get_ivy(opt or {}))
  end
end

vim.keymap.set('n', '<C-p>', ivy(builtin.find_files), {})
vim.keymap.set('n', '<C-g>', ivy(builtin.live_grep), {})
vim.keymap.set('n', '<leader>fb', ivy(builtin.buffers), {})
vim.keymap.set('n', '<space>d', ivy(builtin.diagnostics), {})
vim.keymap.set('n', '<leader>fh', ivy(builtin.help_tags), {})

vim.keymap.set(
  "n",
  "<leader>t",
  function()
    telescope.extensions.file_browser.file_browser({
      path = "%:p:h",
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
