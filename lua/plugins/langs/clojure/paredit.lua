vim.pack.add({ { src = "https://github.com/julienvincent/nvim-paredit" } })

-- Load paredit only on clj files
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "clojure", "edn", "dune" },
	callback = function()
		local paredit = require("nvim-paredit")
		paredit.setup({
			keys = {
				["<localleader>>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
				["<localleader>("] = { paredit.api.slurp_backwards, "Slurp backwards" },

				["<localleader><"] = { paredit.api.barf_forwards, "Barf forwards" },
				["<localleader>)"] = { paredit.api.barf_backwards, "Barf backwards" },

				[">e"] = { paredit.api.drag_element_forwards, "Drag element right" },
				["<e"] = { paredit.api.drag_element_backwards, "Drag element left" },

				[">f"] = { paredit.api.drag_form_forwards, "Drag form right" },
				["<f"] = { paredit.api.drag_form_backwards, "Drag form left" },

				["<localleader>o"] = { paredit.api.raise_form, "Raise form" },
				["<localleader>O"] = { paredit.api.raise_element, "Raise element" },

				["E"] = {
					paredit.api.move_to_next_element,
					"Jump to next element tail",
					-- by default all keybindings are dot repeatable
					repeatable = false,
					mode = { "n", "x", "o", "v" },
				},
				["B"] = {
					paredit.api.move_to_prev_element,
					"Jump to previous element head",
					repeatable = false,
					mode = { "n", "x", "o", "v" },
				},
			},
			indent = {
				enabled = true,
			},
		})
	end,
})
