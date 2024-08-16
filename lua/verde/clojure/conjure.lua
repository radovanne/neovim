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
				table.insert(config.sources, {
					name = "buffer",
					option = {
						sources = {
							{ name = "conjure" },
						},
					},
				})
				cmp.setup(config)
			end,
		},
	},
	init = function()
		-- Set configuration options here
		vim.g["conjure#debug"] = false
	end,
}

function M.config()
	require("conjure.main").main()
	require("conjure.mapping")["on-filetype"]()
	vim.g["conjure#mapping#doc_word"] = ",,gk"
	vim.g["conjure#log#treesitter"] = false
	vim.g["conjure#client_on_load"] = false
	vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false

	-- SciCloj/Clay integration with Conjure written in Lua
	local eval = require("conjure.eval")
	local extract = require("conjure.extract")

	local function eval_clay_form()
		local form_content = extract.form({ root = true }).content
		local source_path = vim.fn.expand("%:p")
		local code =
			string.format('(scicloj.clay.v2.api/make! {:source-path "%s" :single-form %s})', source_path, form_content)

		eval["eval-str"]({
			origin = "custom-clay-wrapper",
			code = code,
		})
	end

	local function eval_clay_ns()
		local source_path = vim.fn.expand("%:p")
		local code = string.format('(scicloj.clay.v2.api/make! {:source-path "%s"})', source_path)
		eval["eval-str"]({
			origin = "custom-clay-wrapper",
			code = code,
		})
	end

	local function eval_clay_hiccup_ns()
		local source_path = vim.fn.expand("%:p")
		local code = string.format('(scicloj.clay.v2.api/make-hiccup {:source-path "%s"})', source_path)
		eval["eval-str"]({
			origin = "custom-clay-wrapper",
			code = code,
		})
	end

	local wk = require("which-key")
	wk.add({
		{ "<localleader>ev", eval_clay_form, desc = "Clay eval form" },
		{ "<localleader>env", eval_clay_ns, desc = "Clay eval ns" },
		{ "<localleader>enh", eval_clay_hiccup_ns, desc = "Clay eval ns hiccup" },
	})
end
return M
