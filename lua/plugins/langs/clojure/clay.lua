local M = {
	{
		"radovanne/clay.nvim",
		ft = { "clojure" },
		config = function()
			local clay = require("clay")
			local wk = require("which-key")
			wk.add({
				{ "<localleader>c", group = "Connect/Clay" },
				{ "<localleader>cs", clay.ClayStart, desc = "Clay start" },
				{ "<localleader>cS", clay.ClayStartAndRender, desc = "Clay start" },
				{ "<localleader>cef", clay.ClayEvalForm, desc = "Clay eval form" },
				{ "<localleader>cen", clay.ClayEvalNamespace, desc = "Clay eval ns" },
				{ "<localleader>ceh", clay.ClayEvalNamespaceToHiccup, desc = "Clay eval ns hiccup" },
				{ "<localleader>ms", "<cmd>:ConjureOutSubscribe<cr>", desc = "ConjureOutSubscribe" },
				{ "<localleader>mo", "<cmd>:ConjureOutUnsubscribe<cr>", desc = "ConjureOutUnsubscribe" },
			})
		end,
	},
}

return M
