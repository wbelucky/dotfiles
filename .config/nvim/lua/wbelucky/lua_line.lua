local M = {
  "nvim-lualine/lualine.nvim",
  requires = { "nvim-tree/nvim-web-devicons", opt = true },
}

M.config = function()
  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = false,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        {
          "diagnostiics",
          sources = { "nvim_diagnostic", "nvim_lsp", "nvim_workspace_diagnostic" },
        },
        "diff",
      },
      lualine_c = {
        {
          "filename",
          path = 1, -- relative path
          symbols = {
            modified = "",
            readonly = "󰷭",
            unnamed = "󰡯",
            newfile = "",
          },
        },
      },
      lualine_x = {},
      lualine_y = { "encoding", "fileformat", "filetype" },
      lualine_z = { "progress" },
      -- lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return M
