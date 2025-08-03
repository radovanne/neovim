vim.pack.add({ { src = "https://github.com/radovanne/clay.nvim" } })

vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "clojure" },
	callback = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function()
				local clay = require("clay")

				vim.keymap.set('n', "<localleader>cs", function() clay.ClayStart() end)
				vim.keymap.set('n', "<localleader>cS", function() clay.ClayStartAndRender() end)
				vim.keymap.set('n', "<localleader>cef", function() clay.ClayEvalForm() end)
				vim.keymap.set('n', "<localleader>cen", function() clay.ClayEvalNamespace() end)
				vim.keymap.set('n', "<localleader>ceh", function() clay.ClayEvalNamespaceToHiccup() end)
			end,
		})
	end,
})
