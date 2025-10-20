vim.pack.add({ { src = "https://github.com/elixir-tools/elixir-tools.nvim" } })

local ok, elixir = pcall(require, "elixir")
if ok then
	local elixirls = require("elixir.elixirls")
	elixir.setup {
		nextls = { enable = false },
		elixirls = {
			enable = false,
			settings = elixirls.settings { -- I Have no idea what this while thing is or does it do anything at all...
				dialyzerEnabled = true,
				fetchDeps = true,
				enableTestLenses = true,
				suggestSpecs = true,
			},
			-- on_attach = function()
			-- 	local wk = require("which-key")
			-- 	wk.add({
			-- 		{ "<localleader>fp", "<cmd>Elixir nextls from-pipe<cr>",      desc = "ElixirFromPipe",    mode = "n" },
			-- 		{ "<localleader>tp", "<cmd>Elixir nextls to-pipe<cr>",        desc = "ElixirToPipe",      mode = "n" },
			-- 		{ "<localleader>em", "<cmd>ElixirExpandMacro<cr>",            desc = "ElixirExpandMacro", mode = "v" },
			-- 		{ "<localleader>ra", "<cmd>Elixir nextls alias-refactor<cr>", desc = "Alias refactor",    mode = "n" },
			-- 	})
			--
			-- end,
		},
		projectionist = { enable = false },
	}
end
