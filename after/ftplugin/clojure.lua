local clay = require("custom.clay")

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

