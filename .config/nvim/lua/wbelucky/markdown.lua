local M = {}

---comment
---@param filename string
---@return integer
---@return integer
---@return string | nil
M.count_todos_and_dones = function(filename)
  local file = io.open(filename, "r")
  if not file then
    return 0, 0, "Could not open file: " .. filename
  end

  local todoCount = 0
  local doneCount = 0

  for line in file:lines() do
    if line:find("%[%s%]") then
      todoCount = todoCount + 1
    elseif line:find("%[x%]") then
      doneCount = doneCount + 1
    end
  end

  file:close()
  return todoCount, doneCount, nil
end

-- local todoCount, doneCount, err = countTodosAndDones("your_file.md")
return M
