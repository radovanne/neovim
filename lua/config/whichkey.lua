-- TODO: Clean keymaps and add nice icons to them
local mappings = {
	{ "<leader>q", "<cmd>confirm q<CR>", desc = "Quit", mode = "n" },
	{ "<Esc>", "<cmd>nohlsearch<CR>", desc = "NOHL", mode = "n" },
	{ "<leader>b", desc = "Buffers" },
	{ "<leader>d", desc = "Debug" },
	{ "<leader>f", desc = "Find" },
	{ "<leader>g", desc = "Git" },
	{ "<leader>l", desc = "LSP" },
	{ "<leader>p", desc = "Plugins" },
	{ "<leader>t", desc = "Test/Term" },
	{ "<leader>e", desc = "Explore" },

	{
		"<leader>ts",
		function()
			vim.cmd("belowright 12split")
			vim.cmd("set winfixheight")
			vim.cmd("term")
			vim.cmd.startinsert()
		end,
		desc = "Term bellow",
	},
}

local wk = require("which-key")
local icons = require("config.icons")

wk.setup({
	disable = {
		filetypes = { "TelescopePrompt" },
	},
	show_help = false,
	show_keys = false,
	win = {
		padding = { 2, 2, 2, 2 },
	},
	icons = {
		separator = icons.ui.ChevronShortRight,
	},
})

wk.add(mappings)
