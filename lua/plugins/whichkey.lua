vim.pack.add({ { src = 'https://github.com/folke/which-key.nvim' } })

local mappings = {
	{ "<leader>q",  "<cmd>confirm q<CR>",  desc = "Quit Neovim",    mode = "n" },
	{ "<Esc>",      "<cmd>nohlsearch<CR>", desc = "NOHL",           mode = "n" },
	{ '<leader>x',  ":w<CR>:so<CR>",       desc = "Write&Source",   mode = "n" },
	{ '<leader>nr',  ":restart<CR>",        desc = "Restart Neovim", mode = "n" },
	{ '<leader>cf', vim.lsp.buf.format,    desc = "Code Format",    mode = "n" },
	{ '<leader>U',  vim.pack.update,       desc = "Update Plugins", mode = "n" },

	{
		"<leader>ts",
		function()
			vim.cmd("belowright 12split")
			vim.cmd("set winfixheight")
			vim.cmd("term")
			vim.cmd.startinsert()
		end,
		desc = "Terminal below",
	},
	-- { "<leader>b",  desc = "Buffers" },
	-- { "<leader>d",  desc = "Debug" },
	-- { "<leader>f",  desc = "Find" },
	-- { "<leader>g",  desc = "Git" },
	-- { "<leader>l",  desc = "LSP" },
	-- { "<leader>p",  desc = "Plugins" },
	-- { "<leader>t",  desc = "Test/Term" },
	-- { "<leader>e",  desc = "Explore" },

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
