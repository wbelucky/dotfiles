---@param options? table additional options
---@param picker_options? table options for the picker
---@param cb function
local function pickTodoOrInProgress(options, picker_options, cb)
  local ui = require "zk.ui"
  local api = require "zk.api"
  ---@see zk.ui.pick_notes
  options =
    vim.tbl_extend("force", { select = ui.get_pick_notes_list_api_selection(picker_options or {}) }, options or {})

  -- FIXME: use coroutine
  api.list(options.notebook_path, vim.tbl_extend("force", options, { tags = { "todo" } }), function(errToDo, notesToDo)
    assert(not errToDo, tostring(errToDo))

    api.list(
      options.notebook_path,
      vim.tbl_extend("force", options, { tags = { "in-progress" } }),
      function(errInProgress, notesInProgress)
        assert(not errInProgress, tostring(errInProgress))
        ui.pick_notes(vim.list_extend(notesInProgress, notesToDo), picker_options, cb)
      end
    )
  end)
end

---@param options? table additional options
---@param picker_options? table options for the picker
---@see https://github.com/zk-org/zk/blob/main/docs/editors-integration.md#zklist
---@see zk.ui.pick_notes
local function editTodoOrInProgress(options, picker_options)
  local zk = require "zk"
  local config = require "zk.config"
  pickTodoOrInProgress(options, picker_options, function(notes)
    if picker_options and picker_options.multi_select == false then
      notes = { notes }
    end
    if config.options.cd_on_edit then
      zk.cd()
    end
    for _, note in ipairs(notes) do
      vim.cmd("e " .. note.absPath)
    end
  end)
end

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
        vim.cmd "normal :"
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
        vim.cmd "normal :"
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
    {
      "<leader>ms",
      function()
        editTodoOrInProgress({}, { title = "Zk on Sprint" })
      end,
      desc = "Pick notes on [S]print",
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
