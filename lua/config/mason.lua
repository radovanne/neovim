---@diagnostic disable: missing-fields
local servers = {
	"lua_ls",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	"clojure_lsp",
	"graphql",
	"yamlls",
}

require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = servers,
})
