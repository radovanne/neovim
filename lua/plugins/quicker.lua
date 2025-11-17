vim.pack.add({ { src = "https://github.com/stevearc/quicker.nvim" } })

local ok, quicker = pcall(require, "quicker")
if ok then
	quicker.setup({
		keys = {
			{
				">",
				function()
					quicker.expand({ before = 2, after = 2, add_to_existing = true })
				end,
				desc = "Expand quickfix context",
			},
			{
				"<",
				function()
					quicker.collapse()
				end,
				desc = "Collapse quickfix context",
			},
		},
	})
end
