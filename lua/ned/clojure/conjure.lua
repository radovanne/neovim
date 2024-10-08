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
		vim.g["conjure#debug"] = false
		vim.g["conjure#mapping#doc_word"] = false
		vim.g["conjure#log#treesitter"] = false
		vim.g["conjure#client_on_load"] = false
		vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
	end,
}

function M.config()
	require("conjure.main").main()
	require("conjure.mapping")["on-filetype"]()

	-- SciCloj/Clay integration with Conjure written in Lua
	local eval = require("conjure.eval")
	local extract = require("conjure.extract")

	local function clay_start()
		local source_path = vim.fn.expand("%:p")
		local code = string.format(
			'(do (require \'[scicloj.clay.v2.api :as clay]) (clay/make! {:source-path "%s"}))',
			source_path
		)

		eval["eval-str"]({
			origin = "custom-clay-wrapper",
			code = code,
		})
	end

	local function clay_eval_form()
		local form_content = extract.form({ root = true }).content
		local source_path = vim.fn.expand("%:p")
		local code =
			string.format('(scicloj.clay.v2.api/make! {:source-path "%s" :single-form %s})', source_path, form_content)

		eval["eval-str"]({
			origin = "custom-clay-wrapper",
			code = code,
		})
	end

	local function clay_eval_ns()
		local source_path = vim.fn.expand("%:p")
		local code = string.format('(scicloj.clay.v2.api/make! {:source-path "%s"})', source_path)
		eval["eval-str"]({
			origin = "custom-clay-wrapper",
			code = code,
		})
	end

	local function clay_eval_ns_to_hiccup()
		local source_path = vim.fn.expand("%:p")
		local code = string.format('(scicloj.clay.v2.api/make-hiccup {:source-path "%s"})', source_path)
		eval["eval-str"]({
			origin = "custom-clay-wrapper",
			code = code,
		})
	end


	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "clojure", "edn" },
		callback = function()
			local wk = require("which-key")

			wk.add({
				{ "<localleader>c", group = "Connect/Clay" },
				{ "<localleader>cs", clay_start, desc = "Clay start" },
				{ "<localleader>cef", clay_eval_form, desc = "Clay eval form" },
				{ "<localleader>cen", clay_eval_ns, desc = "Clay eval ns" },
				{ "<localleader>ceh", clay_eval_ns_to_hiccup, desc = "Clay eval ns hiccup" },
			})
		end,
	})

end
return M
