local crates = require("crates")

crates.setup({
	lsp = {
		enabled = true,
		actions = true,
		completion = true,
	},
	popup = {
		autofocus = true,
		border = "single",
	},
})

-- TODO: Blink integration would be nice
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
	pattern = "Cargo.toml",
	callback = function()
		local wk = require("which-key")

		wk.add({
			{ "<localleader>c", group = "Crates" },
			{ "<localleader>ct", crates.toggle, desc = "Toggle crates." },
			{ "<localleader>cr", crates.reload, desc = "Reload crates." },
			{ "<localleader>cv", crates.show_versions_popup, desc = "Show versions." },
			{ "<localleader>cf", crates.show_features_popup, desc = "Show features." },
			{ "<localleader>cd", crates.show_dependencies_popup, desc = "Show dependencies." },
			{ "<localleader>cu", crates.update_crate, desc = "Update crate." },
			{ "<localleader>ca", crates.update_all_crates, desc = "Update all crates." },
			{ "<localleader>cU", crates.upgrade_crate, desc = "Upgrade crate." },
			{ "<localleader>cA", crates.upgrade_all_crates, desc = "Upgrade all crates." },
			{ "<localleader>cH", crates.open_homepage, desc = "Open homepage." },
			{ "<localleader>cR", crates.open_repository, desc = "Open repository." },
			{ "<localleader>cD", crates.open_documentation, desc = "Open documentation." },
			{ "<localleader>cC", crates.open_crates_io, desc = "Open crates io." },
		})
	end,
})
