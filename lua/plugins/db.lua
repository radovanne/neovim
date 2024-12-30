local M = {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
			config = function()
				local cmp = require("cmp")
				local config = cmp.get_config()
				config.sources = {
					{ name = "vim-dadbod-completion" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}

				cmp.setup(config)
			end,
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
