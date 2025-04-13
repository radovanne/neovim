local conform = require("conform")

conform.setup({
	formatters = {
		rubocop = {
			args = { "-a", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" },
		},
	},
	formatters_by_ft = {
		lua = { "stylua" },
		ruby = { "rubocop", lsp_format = "fallback" },
		eruby = { "erb_format" },
		python = { "isort", "black" },
		ocaml = { "ocamlformat", lsp_format = "fallback" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		go = { "goimports", "gofmt", lsp_format = "fallback" },
		clojure = { "cljfmt", "standard-clj", lsp_format = "fallback", stop_after_first = true },
	},
})

local wk = require("which-key")
wk.add({
	{
		"<leader>cc",
		function()
			conform.format()
		end,
		desc = "Conform Code",
	},
})
