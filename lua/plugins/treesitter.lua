vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = 'https://github.com/andymass/vim-matchup' }
})

vim.g.matchup_matchparen_enabled = 1
vim.g.matchup_matchparen_offscreen = { method = "popup" }

local parsers = {
	"comment",
	"clojure",
	"lua",
	"bash",
	"javascript",
	"typescript",
	"json",
	"yaml",
	"dockerfile",
	"html",
	"css",
	"markdown",
	"vim",
}

require('nvim-treesitter').install(parsers)
