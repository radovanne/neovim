local M = {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
		},
		{ -- optional saghen/blink.cmp completion source
			"saghen/blink.cmp",
			opts = {
				sources = {
					-- add vim-dadbod-completion to your completion providers
					default = { "lsp", "path", "snippets", "buffer", "dadbod" },
					providers = {
						dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					},
				},
			},
		},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
}

M.init = function()
	require("config.db")
end

return M
