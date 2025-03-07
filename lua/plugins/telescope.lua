local M = {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
		{ "nvim-telescope/telescope-ui-select.nvim", lazy = true },
	},
	config = function ()
		require("config.telescope")
	end
}

return M
