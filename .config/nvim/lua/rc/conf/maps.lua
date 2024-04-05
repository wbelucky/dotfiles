local k = vim.keymap.set

k("i", "jj", "<ESC>")
k("c", "jj", "<C-c>")

-- for 🗡Training🗡
-- k("i", "<ESC>", "<Nop>")
-- k("c", "<ESC>", "<Nop>")
k("v", "i", "<Nop>")

k("n", "k", "gk")
k("n", "j", "gj")

k("n", "<leader>x", ":x<CR>")
k("n", "<leader>w", ":w<CR>")
k("n", "<leader>q", ":q<CR>")

k("n", "<leader>d", "<C-d>")
k("n", "<leader>u", "<C-u>")

k("n", "<C-w>H", ":vertical resize -5<CR>")
k("n", "<C-w>J", ":resize -5<CR>")
k("n", "<C-w>K", ":resize +5<CR>")
k("n", "<C-w>L", ":vertical resize +5<CR>")

-- greatest remap ever
k("x", "mp", [["_dP]])

-- next greatest remap ever
k({ "n", "v" }, "md", [["_d]])

local function yank_url()
  local line_number = vim.api.nvim_win_get_cursor(0)[1]
  local line_text = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1]
  local url_pattern = "https?://[%w-_%.%?%.:/%+=&]+"
  local url = line_text:match(url_pattern)
  print(url)

  if url then
    require("osc52").copy(url)
  end
end

k("n", "<leader>l", yank_url, {})
k("n", "<leader><leader>", "<c-w><c-w>", {})
