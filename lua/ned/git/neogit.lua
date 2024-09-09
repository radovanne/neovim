local M = {
  "neogitorg/neogit",
  event = "VeryLazy",
  dependencies = { "sindrets/diffview.nvim" },
}

function M.config()
  local icons = require "ned.icons"
  local wk = require "which-key"
  wk.add{
    { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
  }

  require("neogit").setup {
    auto_refresh = true,
    use_magit_keybindings = true,
    -- Change the default way of opening neogit
    kind = "tab",
    -- Change the default way of opening the commit popup
    commit_popup = {
      kind = "split",
    },
    -- Change the default way of opening popups
    popup = {
      kind = "split",
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      hunk = { "", "" },
    },
  }
end

return M
