local M = {
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
}

function M.config()
	require("config.crates")
end

return M
