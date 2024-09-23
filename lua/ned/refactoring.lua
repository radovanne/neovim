local M = {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}

M.config = function()
	-- TODO: Experimental, remove if it doesn't feel right
	require("refactoring").setup({})
end

return M
