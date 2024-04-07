-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local k = vim.keymap.set

k("n", "<leader><leader>", "<c-w><c-w>", { desc = "Other Window" })
k("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })

k("n", "<leader>w-", "<Nop>")
k("n", "<leader>w|", "<Nop>")
k("n", "<leader>wd", "<Nop>")
k("n", "<leader>ww", "<Nop>")

k("i", "jj", "<ESC>")
k("c", "jj", "<C-c>")

-- for 🗡Training🗡
k("v", "i", "<Nop>")

-- greatest remap ever
k("x", "mp", [["_dP]])

-- next greatest remap ever
k({ "n", "v" }, "md", [["_d]], { desc = '"_d' })

k("n", "mx", [[<cmd>.s/\[\s\]/[x]<cr>]], { desc = "Mark as Done" })
k("n", "m[", [[<cmd>.s/\(\s*\)-\?\s*/\1- [ ] /| nohl<cr>]], { desc = "Add - [ ]" })

-- diagnostics
k("n", "<leader>e", vim.diagnostic.open_float, { desc = "Line Diagnostics ([e]rror)" })
