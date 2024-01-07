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
-- レジスタを保持したままreplace
k("x", "mp", [["_dP]])

-- next greatest remap ever
k("v", "md", [["_d]])
k("n", "<leader><leader>", "<c-w><c-w>", {})
-- k("n", "mt", ":normal!o-[ ] <CR>", {})

k("n", "mm", "o- [ ] ")
k("n", "mt", "I- [ ] <ESC>")

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
