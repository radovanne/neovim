---@diagnostic disable: missing-fields
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
	-- "sorbet",
	-- "ruby_lsp",
	-- "solargraph",
	"rust_analyzer",
	"gopls",
	"tailwindcss",
	"graphql",
	"ols",
	"clangd",
	"yamlls",
}

require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = servers,
})
