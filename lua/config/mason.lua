local servers = {
	"lua_ls",
	"cssls",
	"htmx",
	"emmet_ls",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	"clojure_lsp",
	"intelephense",
	"rust_analyzer",
	"gopls",
	"tailwindcss",
	"graphql",
	"ols",
	"clangd",
}

require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = servers,
})
