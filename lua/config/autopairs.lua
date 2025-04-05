local autopairs = require("nvim-autopairs")
autopairs.setup({
	check_ts = true,
	ts_config = {
		lua = { "string" },
		javascript = { "template_string" },
	},
	enable_check_bracket_line = false,
})

autopairs.get_rules("'")[1].not_filetypes = { "clojure" }
