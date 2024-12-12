-- ref: https://www.lazyvim.org/extras/lang/python

---@type LazySpec
local spec = {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  cmd = "VenvSelect",
  enabled = true,
  opts = {
    settings = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
  },
  --- config = function()
  ---   local venv = vim.fn.findfile("pyproject.toml", vim.fn.getcwd() .. ";")
  ---   if venv ~= "" then
  ---     require("venv-selector").retrieve_from_cache()
  ---   end
  --- end,
  --  Call config for python files and load the cached venv automatically
  ft = "python",
  keys = { { "<leader>cv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv", ft = "python" } },
}

return spec
