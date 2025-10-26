vim.pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master"}})

---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup({
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	ensure_installed = {
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
})

require('nvim-treesitter.install').update({ with_sync = true })

