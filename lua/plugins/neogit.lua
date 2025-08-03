vim.pack.add({
	{ src = "https://github.com/NeogitOrg/neogit" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" }
})


local wk = require("which-key")
local icons = require("config.icons")
wk.add({ { '<leader>gg', "<cmd>Neogit<CR>", desc = "Neogit", mode = "n" } })

require("neogit").setup({
	disable_hint = true,
	signs = {
		section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
		item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
		hunk = { "", "" },
	},
	integrations = {
		telescope = true,
		diffview = true,
		fzf_lua = false,
	},
})
