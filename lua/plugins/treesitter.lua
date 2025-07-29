vim.pack.add({
	{src= "https://github.com/nvim-treesitter/nvim-treesitter"},
})

---@diagnostic disable: missing-fields
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"lua",
		"luadoc",
		"vim",
		"vimdoc",
		"graphql",
		"markdown",
		"markdown_inline",
		"bash",
		"dockerfile",
		"json",
		"xml",
		"yaml",
		"sql",
		"python",
		"typescript",
		"javascript",
		"java",
		"clojure",
		"comment",
	},
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "org" },
	},
	indent = { enable = true },
	sync_install = false,
})
