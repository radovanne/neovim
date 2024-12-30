local M = {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/neodev.nvim",
		},
	},
}

local lsp = require("config.lspconfig")
M.on_attach = lsp.on_attach
M.common_capabilities = lsp.common_capabilities
M.config = lsp.config

return M
