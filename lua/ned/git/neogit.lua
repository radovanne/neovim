local M ={
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = true -- Does this change anything in my setup?
}

function M.config()
  local icons = require "ned.icons"
  local wk = require "which-key"
  wk.add{
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
  }

  require("neogit").setup {
    disable_hint = true, -- Still didn't figure out what hints these are
    signs = {
      section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      hunk = { "", "" },
    },
  }
end

return M
