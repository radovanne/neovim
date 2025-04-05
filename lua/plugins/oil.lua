local M = {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@diagnostic disable-next-line: undefined-doc-name
	---@type oil.SetupOpts
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
}

function M.config()
		require("config.oil")
end

return M
