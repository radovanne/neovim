local M = {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
}

function M.config()
  require("config.rose_pine")
end

return M
