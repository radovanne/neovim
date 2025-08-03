vim.pack.add({ { src = "https://github.com/radovanne/clay.nvim" } })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "clojure" },
	callback = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function()
				local wk = require("which-key")
				local clay = require("clay")

				wk.add({
					{ "<localleader>c",   group = "Clay" },
					{ "<localleader>cs",  function() clay.ClayStart() end,                 desc = "Clay Start" },
					{ "<localleader>cS",  function() clay.ClayStartAndRender() end,        desc = "Clay Start and Render" },
					{ "<localleader>cef", function() clay.ClayEvalForm() end,              desc = "Clay Eval Form" },
					{ "<localleader>cen", function() clay.ClayEvalNamespace() end,         desc = "Clay Eval Namespace" },
					{ "<localleader>ceh", function() clay.ClayEvalNamespaceToHiccup() end, desc = "Clay Eval Namespace to Hiccup" },
				})
			end,
		})
	end,
})
