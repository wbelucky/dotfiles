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

--- https://github.com/hrsh7th/vim-vsnip/blob/master/plugin/vsnip.vim#L65C1-L74C12

vim.api.nvim_create_user_command("VsnipYank", function(args)
  local function add_command(start_line, end_line, name)
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local formatted_lines = {}
    for _, val in ipairs(lines) do
      table.insert(formatted_lines, vim.fn.json_encode(val:gsub("%$", "\\$")))
    end
    local format = [[  "%s": {
    "prefix": ["%s"],
    "body": [
      %s
    ]
  }]]
    local command_name = name ~= "" and name or "new"

    local reg = vim.o.clipboard == "unnamed" and "*" or '"'
    reg = vim.o.clipboard == "unnamedplus" and "+" or reg
    local content = string.format(format, command_name, command_name, table.concat(formatted_lines, ",\n      "))
    vim.fn.setreg(reg, content, { "l" })
  end

  local line1, line2 = unpack(args)
  local q_args = args[3]
  add_command(line1, line2, q_args)
end, {
  range = true,
  nargs = "?",
})
