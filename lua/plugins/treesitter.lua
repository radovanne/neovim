vim.pack.add({ { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = 'https://github.com/andymass/vim-matchup' }
})

vim.g.matchup_matchparen_enabled = 1
vim.g.matchup_matchparen_offscreen = { method = "popup" }
local parsers = {
	"comment",
	"eex",
	"heex",
	"elixir",
	"clojure",
	"lua",
	"bash",
	"javascript",
	"typescript"
}
require('nvim-treesitter').install(parsers)

vim.api.nvim_create_autocmd("FileType",
{
	group = vim.api.nvim_create_augroup("TreesitterSetup",
	{ clear = true }),
	callback = function(event)
		pcall(vim.treesitter.start, event.buf)
	end,
})
