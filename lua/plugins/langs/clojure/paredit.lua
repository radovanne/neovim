local M = {
	"julienvincent/nvim-paredit",
	ft = { "clojure", "edn", "dune" },
}

M.config = function()
	require("config.paredit")
end

return M
