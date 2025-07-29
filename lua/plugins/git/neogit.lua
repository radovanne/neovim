vim.pack.add({
  {src= "https://github.com/nvim-lua/plenary.nvim"},
  {src= "https://github.com/sindrets/diffview.nvim"},
  {src= "https://github.com/nvim-telescope/telescope.nvim"},
  {src= "https://github.com/NeogitOrg/neogit"},
})

local icons = require("config.icons")
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>gg", "<cmd>Neogit<CR>", opts)

require("neogit").setup({
	disable_hint = true,
	signs = {
		section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
		item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
		hunk = { "", "" },
	},
	integrations = {
		telescope = true,
		diffview = true,
		fzf_lua = false,
	},
})
