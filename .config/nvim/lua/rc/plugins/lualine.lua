---@type LazySpec
local spec = {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
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
            -- relative path
            path = 1,
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
  end,
}

return spec
