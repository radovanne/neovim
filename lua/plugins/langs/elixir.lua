vim.pack.add({ { src = "https://github.com/elixir-tools/elixir-tools.nvim" } })

local ok, elixir = pcall(require, "elixir")
if ok then
	elixir.setup {
		nextls = { enable = false },
		elixirls = {
			enable = true,
			on_attach = function()
				local wk = require("which-key")
				wk.add({
					{ "<localleader>c",  group = "Clay" },
					{ "<localleader>fp", "<cmd>ElixirFromPipe<cr>",    desc = "Clay Start",            mode = "n" },
					{ "<localleader>tp", "<cmd>ElixirToPipe<cr>",      desc = "Clay Start and Render", mode = "n" },
					{ "<localleader>em", "<cmd>ElixirExpandMacro<cr>", desc = "Clay Eval Form",        mode = "v" },
				})
			end,
		},
		projectionist = { enable = false },
	}
end
