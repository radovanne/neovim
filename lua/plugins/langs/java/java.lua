local M = {
	"JavaHello/spring-boot.nvim",
	ft = "java",
	config = false,
	dependencies = {
		"mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
		"ibhagwan/fzf-lua", -- optional
	},
}
return M
