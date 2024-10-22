local M = {
  "folke/which-key.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  -- TODO: Clean keymaps and add nice icons to them
  local mappings = {
    { "<leader>q", "<cmd>confirm q<CR>", desc = "Quit", mode = "n"},
    { "<leader>H", "<cmd>nohlsearch<CR>", desc = "NOHL", mode = "n" },
    { "<leader>;", "<cmd>tabnew | terminal<CR>",desc = "Term", mode = "n" },
    { "<leader>v", "<cmd>vsplit<CR>", desc =  "Split", mode = "n" },
    {"<leader>b",  desc = "Buffers" },
    {"<leader>d",  desc = "Debug" },
    {"<leader>f",  desc = "Find" },
    {"<leader>g",  desc = "Git" },
    {"<leader>l",  desc = "LSP" },
    {"<leader>p",  desc = "Plugins" },
    {"<leader>t",  desc = "Test" },
  }

  local which_key = require "which-key"
  which_key.setup {
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = false,
        g = false,
      },
    },
    -- window = {
    --   border = "rounded",
    --   position = "bottom",
    --   padding = { 2, 2, 2, 2 },
    -- },
    -- ignore_missing = true,
    show_help = false,
    show_keys = false,
    disable = {
      buftypes = {},
      filetypes = { "TelescopePrompt" },
    },
  }

  which_key.add(mappings)
end

return M
