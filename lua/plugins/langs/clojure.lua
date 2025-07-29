vim.pack.add({
  {src= "https://github.com/Olical/conjure"},
  {src= "https://github.com/julienvincent/nvim-paredit"},
  {src= "https://github.com/gpanders/nvim-parinfer"},
  {src= "https://github.com/dundalek/parpar.nvim"}
})

local conjure = {
	["conjure#filetype#rust"] = false,
	["conjure#filetype#python"] = false,
	["conjure#debug"] = false,
	["conjure#highlight#enabled"] = true,
	["conjure#mapping#doc_word"] = false,
	-- ["conjure#mapping#doc_word"] = "gk",
	["conjure#extract#tree_sitter#enabled"] = true,
	["conjure#log#treesitter"] = false,
	["conjure#client_on_load"] = false,
	["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false,
	["conjure#client#clojure#nrepl#refresh#backend"] = "clj-reload",
	["conjure#log#wrap"] = true,
}

for key, value in pairs(conjure) do
	vim.g[key] = value
end

local paredit = require("nvim-paredit")

local paredit_conf = {
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
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "clojure"},
  callback = function()
    require("conjure.main").main()
    require("parpar").setup {
      paredit = paredit_conf
    }
  end,
})
