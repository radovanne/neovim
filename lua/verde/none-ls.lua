local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	-- local diagnostics =  null_ls.builtins.diagnostics

	null_ls.setup({
		debug = false,
		sources = {
			formatting.stylua,
			formatting.prettier,
			formatting.black,
			formatting.cljfmt,
			-- No need to use custom formatting for now..
			-- formatting.zprint.with({
			-- 	filetypes = { "clojure", "edn" },
			-- 	command = "zprintm",
			-- }),
			null_ls.builtins.completion.spell,
		},
	})
end

return M
