local k = vim.keymap.set

k("i", "jj", "<ESC>")

k("n", "k", "gk")
k("n", "j", "gj")

k("n", "<C-w>H", ":vertical resize -5<CR>")
k("n", "<C-w>J", ":resize -5<CR>")
k("n", "<C-w>K", ":resize +5<CR>")
k("n", "<C-w>L", ":vertical resize +5<CR>")

-- greatest remap ever
-- レジスタを保持したままreplace
k("x", "<leader>p", [["_dP]])

-- next greatest remap ever
k({ "n", "v" }, "<leader>y", [["+y]])
k("v", "<leader>Y", [["+Y]])
k("v", "<leader>d", [["_d]])

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

-- TODO:
-- " :TermでTerminalが新しいwindowで開く
-- if has('nvim')
--   command! -nargs=* Term split | terminal <args>
--   command! -nargs=* Termv vsplit | terminal <args>
-- endif
--
-- if has('nvim')
--   augroup vimrc_term
--     autocmd!
--     autocmd WinEnter term://* nohlsearch
--     autocmd WinEnter term://* startinsert
--
--     autocmd TermOpen * tnoremap <buffer> <C-W>h <C-\><C-n><C-w>h
--     autocmd TermOpen * tnoremap <buffer> <C-W>j <C-\><C-n><C-w>j
--     autocmd TermOpen * tnoremap <buffer> <C-W>k <C-\><C-n><C-w>k
--     autocmd TermOpen * tnoremap <buffer> <C-W>l <C-\><C-n><C-w>l
--     autocmd TermOpen * tnoremap <buffer> <Esc><Esc> <C-\><C-n>
--   augroup END
-- endif
