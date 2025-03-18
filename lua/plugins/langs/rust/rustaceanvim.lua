local M = {
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		ft = { "rust" },
}

function M.config()
	require("config.rustaceanvim")
end

return M
