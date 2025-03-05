local M = {
	"dundalek/parpar.nvim",
  dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
	ft = { "clojure", "edn", "dune" },
}

M.config = function()
	require("config.parpar")
end

return M
