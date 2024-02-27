local M = {
  "ThePrimeagen/harpoon",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  }
}

function M.config()
  -- set keymaps
  local keymap = vim.keymap -- for conciseness

  local ui = require("harpoon.ui")

  keymap.set("n", "<leader>ha", "<cmd>lua require('verde.harpoon').mark_file()<cr>")
  keymap.set("n", "<leader>he", ui.toggle_quick_menu)

  keymap.set("n", "<leader>hh", function()
    ui.nav_file(1)
  end)
  keymap.set("n", "<leader>hj", function()
    ui.nav_file(2)
  end)
  keymap.set("n", "<leader>hk", function()
    ui.nav_file(3)
  end)
  keymap.set("n", "<leader>hl", function()
    ui.nav_file(4)
  end)
end

function M.mark_file()
    local mark = require("harpoon.mark")
    mark.add_file()
    vim.notify "󱡅  marked file"
end

return M
