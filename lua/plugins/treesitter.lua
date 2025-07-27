local M = {
  "nvim-treesitter/nvim-treesitter",
  -- dependencies = {"HiPhish/rainbow-delimiters.nvim"},
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("config.treesitter")
end

return M
