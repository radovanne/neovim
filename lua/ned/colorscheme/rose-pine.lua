local M = {
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = false,
  priority = 1000,
}

function M.config()
  local rose_pine_16_color_palette = {
    moon = {
      base = "#262626", -- Lighter Dark Gray
      surface = "#333333", -- Between Base and Overlay
      overlay = "#3c3c3c", -- Lightened Overlay
      text = "#D9D1E9", -- Touch of cold lavander
      love = "#C36E70",  -- Red-ish 
    },
  }

  require("rose-pine").setup({
    palette = rose_pine_16_color_palette,
    styles = {
        transparency = false,
  }})
  vim.cmd.colorscheme("rose-pine-moon")
end

return M
