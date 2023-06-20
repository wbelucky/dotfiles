local util = {}

---comment
---@param o any
---@return string|unknown
util.dump = function(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. util.dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end

local debug = {}

---comment
---@param s any
util.push_debug = function(s)
  table.insert(debug, s)
end

---comment
util.print_debug = function()
  print(util.dump(util.debug))
end

return util
