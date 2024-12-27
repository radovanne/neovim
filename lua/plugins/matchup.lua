local M = {
	"andymass/vim-matchup",
	config = function()
		vim.g.matchup_matchparen_offscreen = { method = "popup" }
		---@diagnostic disable: missing-fields
		local config = require("nvim-treesitter.configs")
		config.setup({
			matchup = {
				enable = true,
			},
		})
	end,
}

return M
