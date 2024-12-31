local M = {
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
}

function M.config()
	require("config.rustaceanvim")
end

return M
