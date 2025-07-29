vim.pack.add({
  {src= "https://github.com/nvim-tree/nvim-web-devicons"},
  {src= "https://github.com/stevearc/oil.nvim"},
  {src= "https://github.com/nvim-telescope/telescope.nvim"},
  {src= "https://github.com/NeogitOrg/neogit"},
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local detail = false
require("oil").setup({
  float = {
    max_height = 20,
    max_width = 60,
  },
  delete_to_trash = true,
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
	detail = not detail
	if detail then
	  require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
	else
	  require("oil").set_columns({ "icon" })
	end
      end,
    },
  },
})

keymap("n", "-", "<CMD>Oil --float<CR>", opts, { desc = "Open parent directory" })
