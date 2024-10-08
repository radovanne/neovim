local M = {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		-- "nvim-telescope/telescope.nvim", -- optional
		"ibhagwan/fzf-lua", -- optional
	},
	-- config = true -- Does this change anything in my setup?
}

function M.config()
	local icons = require("ned.icons")
	local wk = require("which-key")
	wk.add({
		{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
	})

	require("neogit").setup({
		disable_hint = true, -- Still didn't figure out what hints these are
		signs = {
			section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
			item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
			hunk = { "", "" },
		},
		integrations = {
			-- If enabled, use telescope for menu selection rather than vim.ui.select.
			-- Allows multi-select and some things that vim.ui.select doesn't.
			telescope = false,
			-- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
			-- The diffview integration enables the diff popup.
			--
			-- Requires you to have `sindrets/diffview.nvim` installed.
			diffview = true,
			-- If enabled, uses fzf-lua for menu selection. If the telescope integration
			-- is also selected then telescope is used instead
			-- Requires you to have `ibhagwan/fzf-lua` installed.
			fzf_lua = true,
		},
	})
end

return M
