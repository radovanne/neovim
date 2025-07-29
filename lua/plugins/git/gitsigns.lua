vim.pack.add({
  {src= "https://github.com/lewis6991/gitsigns.nvim"},
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local gitsigns = require("gitsigns")

keymap("n", "<leader>gl", gitsigns.blame_line, opts)

gitsigns.setup({
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	update_debounce = 200,
	max_file_length = 40000,
	preview_config = {
		border = "rounded",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
})
