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

local function get_lines_in_range(range)
  local A = range["start"]
  local B = range["end"]

  local lines = vim.api.nvim_buf_get_lines(0, A.line, B.line + 1, true)
  if vim.tbl_isempty(lines) then
    return nil
  end
  local MAX_STRING_SUB_INDEX = 2 ^ 31 - 1 -- LuaJIT only supports 32bit integers for `string.sub` (in block selection B.character is 2^31)
  lines[#lines] = string.sub(lines[#lines], 1, math.min(B.character, MAX_STRING_SUB_INDEX))
  lines[1] = string.sub(lines[1], math.min(A.character + 1, MAX_STRING_SUB_INDEX))
  return lines
end

---@param lines string[]
---@return string|nil title
---@return string[] body_lines
local function reduce_headings(lines)
  local h1_title = nil
  local reduce_count = 0
  local first_content_line_num = nil

  ---@param i integer
  local function processLines(i)
    local line = lines[i]

    local hashes, title = string.match(line, "^(#+) (%S.*)")

    -- TODO: なぜかtitleのときにこれが表示されない.
    -- print(vim.inspect { hashes, title })

    if first_content_line_num == nil and string.match(line, "%S") ~= nil then
      first_content_line_num = i

      if hashes ~= nil then
        h1_title = title
        reduce_count = string.len(hashes) - 1
      else
        h1_title = line
      end

      lines[i] = ""
      return
    end

    if hashes ~= nil and h1_title ~= nil then
      local hash_num = math.max(string.len(hashes) - reduce_count, 2)
      hashes = string.rep("#", hash_num)
      lines[i] = hashes .. " " .. title
      return
    end
  end

  for i, _ in ipairs(lines) do
    processLines(i)
  end

  return h1_title, vim.list_slice(lines, first_content_line_num + 1)
end

local function zk_new_partial_md(options)
  local util = require "zk.util"

  local location = util.get_lsp_location_from_selection()
  local selected_text = get_lines_in_range(location.range)
  assert(selected_text ~= nil, "No selected text")

  local title, body = reduce_headings(selected_text)

  options = options or {}
  options.title = title or "title"
  options.content = table.concat(body, "\n")

  if options.inline == true then
    options.inline = nil
    options.dryRun = true
    options.insertContentAtLocation = location
  else
    options.insertLinkAtLocation = location
  end

  require("zk").new(options)
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
      desc = "Diary",
    },
    {
      "<leader>my",
      function()
        vim.cmd "normal :"
        zk_new_partial_md {
          group = "posts",
          dir = "posts",
          extra = {
            -- tags = "tag1\ntag2",
            tags = "backlog",
          },
        }
      end,
      desc = "Zk yank from partial md",
      mode = "v",
    },
    {
      "<leader>mt",
      function()
        require("zk.commands").get "ZkTags" {}
      end,
      desc = "Zk Tags",
      mode = "n",
    },
    {
      "<leader>ms",
      function()
        -- this is ok, but i want to sort by tag
        -- require("zk.commands").get "ZkNotes" {
        --   tags = ["todo OR in-progress"]
        -- }

        editTodoOrInProgress({}, { title = "Zk on Sprint" })
      end,
      desc = "Zk Sprint",
      mode = "n",
    },
    {
      "<leader>mb",
      function()
        require("zk.commands").get "ZkBacklinks" {}
      end,
      desc = "Zk Backlinks",
      mode = "n",
    },
    {
      "<leader>mr",
      function()
        require("zk.commands").get "ZkNotes" {
          sort = { "modified-" },
          modifiedAfter = "last one week",
        }
      end,
      desc = "Zk Recent",
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
