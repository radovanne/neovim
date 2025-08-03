vim.pack.add({
	{ src = 'https://github.com/andymass/vim-matchup' },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" }
})

vim.g.matchup_matchparen_offscreen = { method = "popup" }
---@diagnostic disable: missing-fields
local config = require("nvim-treesitter.configs")
config.setup({
	matchup = {
		enable = true,
	},
})
