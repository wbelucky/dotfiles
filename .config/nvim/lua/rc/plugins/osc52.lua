---@type LazySpec
local spec = {
  "ojroques/nvim-osc52",
  event = "TextYankPost",
  keys = {
    {
      "<leader>c",
      function()
        require("osc52").copy_operator()
      end,
      mode = "n",
      { expr = true },
    },

    {
      "<leader>cc",
      "<leader>c_",
      mode = "n",
      { remap = true },
    },
    {
      "<leader>c",
      function()
        require("osc52").copy_visual()
      end,
      mode = "x",
    },
  },
  config = function()
    require("osc52").setup {}
    local function copy()
      if vim.v.event.operator == "y" and vim.v.event.regname == "+" then
        require("osc52").copy_register "+"
      end
    end

    vim.api.nvim_create_autocmd("TextYankPost", { callback = copy })
  end,
}
return spec
