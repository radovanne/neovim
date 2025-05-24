---@diagnostic disable: missing-fields
local servers = {
	"lua_ls",
	"cssls",
	-- "htmx",
	"emmet_ls",
	"ts_ls",
	"pyright",
	"bashls",
	"jsonls",
	-- "clojure_lsp",
	"intelephense",
	"rust_analyzer",
	"gopls",
	"tailwindcss",
	"graphql",
	"yamlls",
}

require("mason").setup({})

require("mason-lspconfig").setup({
	ensure_installed = servers,
})

require("mason-nvim-dap").setup({
	ensure_installed = {"java-test","java-debug-adapter"},
})
