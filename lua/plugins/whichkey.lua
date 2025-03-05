local M = {
  "folke/which-key.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("config.whichkey")
end

return M
