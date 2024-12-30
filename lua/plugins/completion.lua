local M = {
	"hrsh7th/nvim-cmp", -- autocompletion plugin
	event = "InsertEnter",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp", -- source for LSP completions
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-emoji", -- source for emoji completions
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-buffer", -- source for text in buffer
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-path", -- source for file system paths
			event = "InsertEnter",
		},
		{
			"hrsh7th/cmp-cmdline", -- source for command line completions
			event = "InsertEnter",
		},
		{
			"saadparwaiz1/cmp_luasnip", -- for autocompletion
			event = "InsertEnter",
		},
		{
			"L3MON4D3/LuaSnip", -- snippet engine
			event = "InsertEnter",
			dependencies = {
				"rafamadriz/friendly-snippets",
			},
		},
		{
			"hrsh7th/cmp-nvim-lua", -- source for nvim lua completions
		},
		--{
		--  "onsails/lspkind.nvim",  -- vs-code like pictograms
		--}
	},
}

function M.config()
	require("config.completion")
end

return M
