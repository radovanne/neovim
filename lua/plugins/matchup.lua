vim.pack.add({
  {src= "https://github.com/andymass/vim-matchup"},
})

vim.g.matchup_matchparen_offscreen = { method = "popup" }
---@diagnostic disable: missing-fields
local config = require("nvim-treesitter.configs")
config.setup({
  matchup = {
    enable = true,
  },
})

