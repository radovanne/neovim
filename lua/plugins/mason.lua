local M = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
}

function M.config()
	local servers = {
		"lua_ls",
		-- "emmet_language_server",
		"cssls",
		"htmx",
		-- "html",
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
		"clangd"
	}

	require("mason").setup({})

	require("mason-lspconfig").setup({
		ensure_installed = servers,
	})
end

return M
