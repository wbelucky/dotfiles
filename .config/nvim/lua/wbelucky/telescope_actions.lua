local transform_mod = require("telescope.actions.mt").transform_mod
local action_state = require('telescope.actions.state')
local action_set = require "telescope.actions.set"
local fb_utils = require "telescope._extensions.file_browser.utils"
local Path = require "plenary.path"

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

-- from pr: selection_callback after going to parent dir https://github.com/nvim-telescope/telescope-file-browser.nvim/pull/193
-- ref: https://github.com/nvim-telescope/telescope-file-browser.nvim/blob/6eb6bb45b7a9bed94a464a3e1dadfe870459628c/lua/telescope/_extensions/file_browser/actions.lua#L526
wb_actions.goto_parent_dir_with_select_cb = function(prompt_bufnr, bypass)
  bypass = vim.F.if_nil(bypass, true)
  local current_picker = action_state.get_current_picker(prompt_bufnr)
  local finder = current_picker.finder
  local current_dir_path = Path:new(finder.path)
  local parent_dir = current_dir_path:parent():absolute()

  if not bypass then
    if vim.loop.cwd() == finder.path then
      fb_utils.notify(
        "action.goto_parent_dir",
        { msg = "You cannot bypass the current working directory!", level = "WARN", quiet = finder.quiet }
      )
      return
    end
  end

  finder.path = parent_dir
  fb_utils.redraw_border_title(current_picker)
  fb_utils.selection_callback(current_picker, current_dir_path:absolute())
  current_picker:refresh(finder, { reset_prompt = true, multi = current_picker._multi })
end

wb_actions = transform_mod(wb_actions)


wb_actions.get_target_dir = function(prompt_bufnr)
  local finder = action_state.get_current_picker(prompt_bufnr).finder
  return get_target_dir(finder)
end

return wb_actions
