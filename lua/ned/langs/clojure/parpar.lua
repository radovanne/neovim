local M = {
	"dundalek/parpar.nvim",
	ft = { "clojure", "edn", "dune"},
	dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
	config = function()
		local paredit = require("nvim-paredit")
		vim.g["parinfer_mode"] = "smart"
		require("parpar").setup({
			paredit = {
				-- pass any nvim-paredit options here
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
			},
		})
	end,
}

return M
