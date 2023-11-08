-- name -> opt -> () -> void
local function builtin(name)
  return function(opt)
    return function()
      local ivy = require("telescope.themes").get_ivy
      return require("telescope.builtin")[name](ivy(opt or {}))
    end
  end
end

-- (name, prop) -> opt -> () -> void
local function extensions(name, prop)
  return function(opt)
    return function()
      local telescope = require "telescope"
      telescope.load_extension(name)
      local ivy = require("telescope.themes").get_ivy
      return telescope.extensions[name][prop](ivy(opt or {}))
    end
  end
end

---@type LazySpec
local spec = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-ghq.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
  },
  init = function()
    vim.keymap.set("n", "<leader>p", builtin "find_files" {})
    vim.keymap.set("n", "<leader>g", builtin "live_grep" {})
    vim.keymap.set("n", "<leader>b", builtin "buffers" {})
    vim.keymap.set("n", "<leader>o", builtin "oldfiles" {})
    vim.keymap.set("n", "<leader>D", builtin "diagnostics" {})
    vim.keymap.set("n", "\\th", builtin "help_tags" {})
    vim.keymap.set("n", "gs", builtin "git_status" {})
    vim.keymap.set("n", "<leader>Ggst", builtin "git_stash" {})
    vim.keymap.set("n", "<leader>Gc", builtin "git_commits" {})
    vim.keymap.set("n", "<leader>Gb", builtin "git_branches" {})
    vim.keymap.set("n", "\\tb", builtin "builtin" {})
    vim.keymap.set("n", "gq", extensions("ghq", "list") {})

    local open_fb = function()
      extensions("file_browser", "file_browser") {
        path = "%:p:h",
        cwd = vim.fn.expand "%:p:h",
        -- previewer = false,
        -- layout_config = { height = 40 }
      }()
    end
    vim.keymap.set("n", "<leader>t", open_fb)

    vim.keymap.set("n", "<leader><C-p>", function()
      builtin "find_files" { cwd = vim.fn.expand "%:p:h" }()
    end)
    vim.keymap.set("n", "<leader><C-g>", function()
      builtin "live_grep" { cwd = vim.fn.expand "%:p:h" }()
    end)
  end,
  config = function()
    -- local builtin = require("telescope.builtin")
    local ivy = require("telescope.themes").get_ivy
    local telescope = require "telescope"
    local actions = require "telescope.actions"
    local wb_actions = require "rc.plugins.telescope.telescope_actions"
    local fb_actions = require "telescope._extensions.file_browser.actions"

    local git_icons = {
      added = "🏁",
      changed = "🚧",
      copied = "💫",
      deleted = "🔥",
      renamed = "🚚",
      unmerged = "🔀",
      untracked = "✨",
    }

    telescope.setup {
      defaults = {
        mappings = {},
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {
          -- args of ripgrep. ref: .ripgreprc in $RIPGREP_CONFIT_PATH
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        git_files = ivy {},
        git_status = {
          git_icons = git_icons,
          initial_mode = "normal",
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
        ["ui-select"] = ivy {},
        file_browser = ivy {
          grouped = true,
          hidden = true,
          hijack_netrw = true,
          select_buffer = true,
          git_status = true,
          respect_gitignore = false,
          -- https://github.com/nvim-telescope/telescope-file-browser.nvim/pull/171
          git_icons = git_icons,
          initial_mode = "normal",
          default_selection_index = 2,
          mappings = {
            n = {
              -- ["c"] = fb_actions.create,
              ["c"] = false,
              ["ma"] = fb_actions.create,
              -- ["r"] = fb_actions.rename,
              ["r"] = false,
              ["mn"] = fb_actions.rename,
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
                builtin "live_grep" { cwd = dir }()
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
                builtin "find_files" { cwd = dir }()
              end,
              ["/"] = function()
                vim.cmd "startinsert"
              end,
            },
            i = {
              ["<CR>"] = wb_actions.select_default,
            },
          },
        },
      },
    }
    require("telescope").load_extension "ui-select"
  end,
}

return spec
