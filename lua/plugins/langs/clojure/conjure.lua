local M = {
	"Olical/conjure",
	ft = { "clojure", "edn" },
	event = "LspAttach",
	init = function()
		require("config.conjure")
	end,
}

return M
