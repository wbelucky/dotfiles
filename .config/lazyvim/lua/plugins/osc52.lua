---@type LazySpec
local spec = {
  "ojroques/nvim-osc52",
  event = "TextYankPost",
  keys = {
    {
      "<leader>y",
      mode = "n",
      function()
        local line_number = vim.api.nvim_win_get_cursor(0)[1]
        local line_text = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]
        local url_pattern = "https?://[%w-_%.%?%.:/%+=&#]+"
        local url = line_text:match(url_pattern)
        print(url)

        if url then
          require("osc52").copy(url)
        end
      end,
      desc = "Yank the first URL of current line",
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
