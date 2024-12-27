local M = {
	"Olical/conjure",
	ft = { "clojure", "edn" },
	event = "LspAttach",
	init = function ()
		require("config.conjure")
	end,
	-- [Optional] cmp-conjure for cmp
	dependencies = {
		{
			"PaterJason/cmp-conjure",
			config = function()
				local cmp = require("cmp")
				local config = cmp.get_config()
				config.sources = {
					{ name = "conjure" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
					{ name = "luasnip" },
					{ name = "emoji" },
					{ name = "calc" },
				}
				return cmp.setup(config)
			end,
		},
	},
}

return M
