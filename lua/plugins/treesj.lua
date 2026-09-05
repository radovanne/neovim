vim.pack.add({ { src = "https://github.com/Wansmer/treesj" } })

require("treesj").setup({
	use_default_keymaps = false,
})

local wk = require("which-key")
wk.add({
	{ "<leader>j", function() require("treesj").toggle() end, desc = "Split/join block", mode = "n" },
})
