local M = {
	"chipsenkbeil/org-roam.nvim",
	dependencies = {
		{
			"nvim-orgmode/orgmode",
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = {},
		},
		{
			"nvim-orgmode/telescope-orgmode.nvim",
			dependencies = {
				"nvim-orgmode/orgmode",
				"nvim-telescope/telescope.nvim",
			},
		},
		{
			"akinsho/org-bullets.nvim",
			config = function()
				require("config.org.org-bullets")
			end,
		},
		{
			"massix/org-checkbox.nvim",
			config = function()
				require("orgcheckbox").setup()
			end,
		},
	},
}

M.config = function()
	require("config.org.orgroam")
end

return M
