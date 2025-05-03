local M = {
	{
		"radovanne/clay.nvim",
		ft = { "clojure" },
		branch = "add-v2-snippets",
		config = function()
			local clay = require("clay")
			local wk = require("which-key")
			wk.add({
				{ "<localleader>c", group = "Connect/Clay" },
				{ "<localleader>cs", clay.start, desc = "Clay start" },
				{ "<localleader>cS", clay.start_and_render, desc = "Clay start" },
				{ "<localleader>cef", clay.eval_form, desc = "Clay eval form" },
				{ "<localleader>cen", clay.eval_ns, desc = "Clay eval ns" },
				{ "<localleader>ceh", clay.eval_ns_to_hiccup, desc = "Clay eval ns hiccup" },
				{ "<localleader>ms", "<cmd>:ConjureOutSubscribe<cr>", desc = "ConjureOutSubscribe" },
				{ "<localleader>mo", "<cmd>:ConjureOutUnsubscribe<cr>", desc = "ConjureOutUnsubscribe" },
			})
		end,
	},
}

return M
