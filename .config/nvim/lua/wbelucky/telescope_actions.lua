local builtin = require("telescope.builtin")
local transform_mod = require("telescope.actions.mt").transform_mod
local action_state = require('telescope.actions.state')
local action_set = require "telescope.actions.set"

-- ref: https://github.com/nvim-telescope/telescope-file-browser.nvim/blob/efd17359e5e224ac5f5f0e8b1629d8a66f1819e6/lua/telescope/_extensions/file_browser/actions.lua#L53
-- utility to get absolute path of target directory for create, copy, moving files/folders
local get_target_dir = function(finder)
  local entry_path
  if finder.files == false then
    local entry = action_state.get_selected_entry()
    entry_path = entry and entry.value -- absolute path
  end
  return finder.files and finder.path or entry_path
end

local wb_actions = {}

wb_actions.select_default = {
  pre = function(prompt_bufnr)
    action_state
        .get_current_history()
        :append(action_state.get_current_line(), action_state.get_current_picker(prompt_bufnr), true)
  end,
  action = function(prompt_bufnr)
    return action_set.select(prompt_bufnr, "default")
  end,
  post = function(_)
    vim.cmd('stopinsert')
  end
}

wb_actions.find_files_fb = function(prompt_bufnr)
  local finder = action_state.get_current_picker(prompt_bufnr).finder
  local dir = get_target_dir(finder)
  builtin.find_files({
    search_dirs = { dir }
  })
end

wb_actions = transform_mod(wb_actions)

return wb_actions
