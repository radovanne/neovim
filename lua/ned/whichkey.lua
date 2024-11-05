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

  local terminalMappings = {
		{ "<leader>t", group = "Term/Test" },
		{ "<leader>ts", function()
			vim.cmd("belowright 12split")
			vim.cmd("set winfixheight")
			vim.cmd("term")
			vim.cmd("startinsert")
		end, desc = "Term bellow" },
		{ "<leader>tt", function()
			vim.cmd.tabnew()
			vim.cmd.terminal()
			vim.cmd.startinsert()
			require("harpoon"):list("term"):add()
		end, desc = "Terminal buffer" },
	}

  local wk = require "which-key"
  wk.setup {
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

  wk.add(mappings)
  wk.add(terminalMappings)
end

return M
