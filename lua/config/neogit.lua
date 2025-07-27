local icons = require("config.icons")
local wk = require("which-key")
wk.add({
	{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
})

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
