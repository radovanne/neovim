local M = {
	"adalessa/laravel.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"tpope/vim-dotenv",
		"MunifTanjim/nui.nvim",
		"nvimtools/none-ls.nvim",
	},
	cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
	event = { "VeryLazy" },
}

function M.config()
	local wk = require("which-key")

	wk.register({
		l = {
			name = "Laravel",
			a = { ":Laravel artisan<cr>", "Toggle artisan." },
			r = { ":Laravel routes<cr>", "Routes." },
			m = { ":Laravel related<cr>", "Related." },
		},
	}, {
		mode = "n",
		prefix = "<localleader>",
	})

	local laravel = require("laravel")
	laravel.setup({
		lsp_server = "intelephense",
		register_user_commands = true,
		features = {
			null_ls = {
				enable = true,
			},
			route_info = {
				enable = true,
				position = "right",
			},
		},
		ui = require("laravel.config.ui"),
		commands_options = require("laravel.config.command_options"),
		environments = require("laravel.config.environments"),
		user_commands = require("laravel.config.user_commands"),
		resources = require("laravel.config.resources"),
	})
end

return M
