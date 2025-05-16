local M = {
	"JavaHello/java-deps.nvim",
	ft = {"java"},
	config = function()
		require("java-deps").setup({})
		local wk = require("which-key")
		wk.add({
			{ "<localleader>jt", "<cmd>lua require('java-deps').toggle_outline()<cr>", desc = "JavaProject toggle" },
			{ "<localleader>jo", "<cmd>lua require('java-deps').open_outline()<cr>", desc = "JavaProject open" },
			{ "<localleader>jc", "<cmd>lua require('java-deps').close_outline()<cr>", desc = "JavaProject close" },
		})
	end,
}

return M
