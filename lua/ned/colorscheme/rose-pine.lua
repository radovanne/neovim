local M = {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
}

function M.config()
  local rose_pine_custom = {
    moon = {
      -- base = "#262626", -- Lighter Dark Gray
      -- surface = "#333333", -- Between Base and Overlay
      -- overlay = "#3c3c3c", -- Lightened Overlay
      base = "#161616",    -- Darker than #1f1f1f
      surface = "#202020",  -- Darker than #292929
      overlay = "#2a2a2a",  -- Darker than #333333
      text = "#D9D1E9", -- Touch of cold lavander
      love = "#C36E70",  -- Red-ish 
    },
  }

  require("rose-pine").setup({
    -- disable_background = true,
    palette = rose_pine_custom,
    styles = {
      transparency = false,
    }})
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.cmd.colorscheme("rose-pine-moon")
end

return M
