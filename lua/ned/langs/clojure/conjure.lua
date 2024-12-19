local M = {
	"Olical/conjure",
	ft = { "clojure", "edn" }, -- etc
	event = "LspAttach",
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
	init = function()
		-- Set configuration options here
		vim.g["conjure#filetype#rust"] = false
		vim.g["conjure#filetype#python"] = false
		vim.g["conjure#filetype#lua"] = false
		vim.g["conjure#debug"] = false
		vim.g["conjure#highlight#enabled"] = true
		vim.g["conjure#mapping#doc_word"] = "gk"
		vim.g["conjure#log#treesitter"] = false
		vim.g["conjure#client_on_load"] = false
		vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
		vim.g["conjure#client#clojure#nrepl#refresh#backend"] = true
		vim.g["conjure#log#wrap"] = true
	end,
}

function M.config()
	require("conjure.main").main()
	local clay = require("ned.langs.clojure.clay")

	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "clojure", "edn" },
		callback = function()
			local wk = require("which-key")
			require("conjure.mapping")["on-filetype"]()
			wk.add({
				{ "<localleader>c", group = "Connect/Clay" },
				{ "<localleader>cs", clay.start, desc = "Clay start" },
				{ "<localleader>cef", clay.eval_form, desc = "Clay eval form" },
				{ "<localleader>cen", clay.eval_ns, desc = "Clay eval ns" },
				{ "<localleader>ceh", clay.eval_ns_to_hiccup, desc = "Clay eval ns hiccup" },
			})
		end,
	})

end
return M
