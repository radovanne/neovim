local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufEnter",
  cmd = "Gitsigns",
	config = function ()
		require("config.gitsigns")
	end
}


return M
