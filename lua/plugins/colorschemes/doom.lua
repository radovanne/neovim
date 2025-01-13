local M = {
	"NTBBloodbath/doom-one.nvim",
	setup = function()
		-- Add color to cursor
		vim.g.doom_one_cursor_coloring = false
		-- Set :terminal colors
		vim.g.doom_one_terminal_colors = true
		-- Enable TS support
		vim.g.doom_one_enable_treesitter = true
		-- Plugins integration
		vim.g.doom_one_plugin_telescope = true
		vim.g.doom_one_plugin_neogit = true
		vim.g.doom_one_plugin_whichkey = true
	end,
	config = function()
		vim.cmd("colorscheme doom-one")
	end,
}

return M
