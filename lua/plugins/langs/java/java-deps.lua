local M = {
	"JavaHello/java-deps.nvim",
	lazy = true,
	config = function()
		require("java-deps").setup({})
	end,
}

return M
