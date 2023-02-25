local status, telescope = pcall(require, "telescope")
if (not status) then return end

local builtin = require("telescope.builtin")
local actions = require('telescope.actions')
local wb_actions = require('wbelucky.telescope_actions')
local fb_actions = require("telescope._extensions.file_browser.actions")
local ivy = require('telescope.themes').get_ivy

local git_icons = {
  added = '🏁',
  changed = '🚧',
  copied = '💫',
  deleted = '🔥',
  renamed = '🚚',
  unmerged = '🔀',
  untracked = '✨',
}

telescope.setup {
  defaults = {
    mappings = {
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
    },
    git_status = {
      initial_mode = "normal",
      git_icons = git_icons,
    },
    git_branch = {
      initial_mode = "normal",
    }
  },
  extensions = {
    file_browser = {
      grouped = true,
      hidden = true,
      hijack_netrw = true,
      initial_mode = "normal",
      select_buffer = true,
      git_status = true,
      theme = "ivy",
      respect_gitignore = false,
      -- https://github.com/nvim-telescope/telescope-file-browser.nvim/pull/171
      git_icons = git_icons,
      mappings = {
        n = {
          -- ["c"] = fb_actions.create,
          ["c"] = false,
          ["ma"] = fb_actions.create,
          -- ["r"] = fb_actions.rename,
          ["r"] = false,
          ["mr"] = fb_actions.rename,
          -- ["m"] = fb_actions.move,
          ["m"] = false,
          ["mm"] = fb_actions.move,
          -- ["y"] = fb_actions.copy,
          ["y"] = fb_actions.copy,
          -- ["d"] = fb_actions.remove,
          ["d"] = false,
          ["md"] = fb_actions.remove,
          -- ["o"] = fb_actions.open,
          ["x"] = fb_actions.open,
          -- ["g"] = fb_actions.goto_parent_dir,
          ["g"] = function(prompt_bufnr)
            local dir = wb_actions.get_target_dir(prompt_bufnr)
            actions.close(prompt_bufnr)
            builtin.live_grep(ivy { cwd = dir })
          end,
          -- ["e"] = fb_actions.goto_home_dir,
          ["e"] = fb_actions.goto_home_dir,
          -- ["w"] = fb_actions.goto_cwd,
          ["w"] = fb_actions.goto_cwd,
          -- ["t"] = fb_actions.change_cwd,
          ["t"] = actions.select_tab,
          ["cd"] = fb_actions.change_cwd,
          -- ["f"] = fb_actions.toggle_browser,
          ["f"] = fb_actions.toggle_browser,
          -- ["h"] = fb_actions.toggle_hidden,
          ["h"] = wb_actions.goto_parent_dir_with_select_cb,
          -- ["s"] = fb_actions.toggle_all,
          ["s"] = actions.select_vertical,
          ["l"] = actions.select_default,
          ["p"] = function(prompt_bufnr)
            local dir = wb_actions.get_target_dir(prompt_bufnr)
            actions.close(prompt_bufnr)
            builtin.find_files(ivy { cwd = dir })
          end,
          ["/"] = function()
            vim.cmd('startinsert')
          end,
        },
        i = {
          ["<CR>"] = wb_actions.select_default,
        }
      },
    }
  }
}

telescope.load_extension("file_browser")

local ivy_fn = function(fn)
  return function() return fn(ivy {}) end
end

vim.keymap.set('n', '<C-p>', ivy_fn(builtin.find_files), {})
vim.keymap.set('n', '<C-g>', ivy_fn(builtin.live_grep), {})
vim.keymap.set('n', '<leader>b', ivy_fn(builtin.buffers), {})
vim.keymap.set('n', '<leader>o', ivy_fn(builtin.oldfiles), {})
vim.keymap.set('n', '<leader>d', ivy_fn(builtin.diagnostics), {})
vim.keymap.set('n', '<leader>th', ivy_fn(builtin.help_tags), {})
vim.keymap.set('n', '<leader>gs', ivy_fn(builtin.git_status), {})
vim.keymap.set('n', '<leader>ggst', ivy_fn(builtin.git_stash), {})
vim.keymap.set('n', '<leader>gc', ivy_fn(builtin.git_commits), {})
vim.keymap.set('n', '<leader>gb', ivy_fn(builtin.git_branches), {})
vim.keymap.set('n', '<leader>tb', ivy_fn(builtin.builtin), {})
local open_fb = function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = vim.fn.expand('%:p:h'),
    -- previewer = false,
    -- layout_config = { height = 40 }
  })
end
vim.keymap.set("n", "<leader>t", open_fb, {})
vim.keymap.set("n", "\\t", open_fb, {})

vim.keymap.set("n", "<leader>p.", function()
  builtin.find_files(ivy { cwd = vim.fn.expand('%:p:h') })
end, {})
vim.keymap.set("n", "<leader>g.", function()
  builtin.live_grep(ivy { cwd = vim.fn.expand('%:p:h') })
end, {})
