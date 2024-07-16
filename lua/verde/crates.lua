local M = {
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
}

function M.config()
	local crates, cmp = require("crates"), require("cmp")

	crates.setup({
		lsp = {
			enabled = true,
			actions = true,
			completion = true,
		},
		src = {
			cmp = { enabled = true },
		},
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
		popup = {
			autofocus = true,
			border = "single",
		},
	})

	local function enable_cmp_cargo_completion()
		local cmp_config = cmp.get_config()
		table.insert(cmp_config.sources, { name = "crates" })
		cmp.setup(cmp_config)
	end

	vim.api.nvim_create_autocmd("BufRead", {
		group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
		pattern = "Cargo.toml",
		callback = function(event)
			enable_cmp_cargo_completion()
			print("Cargo.toml detected, enabling cmp source crates")

			local wk = require("which-key")

			wk.add({
				{"<localleader>c", group = "Crates"},
				{"<localleader>ct", crates.toggle,desc = "Toggle crates." },
				{"<localleader>cr", crates.reload,desc = "Reload crates." },
				{"<localleader>cv", crates.show_versions_popup,desc = "Show versions." },
				{"<localleader>cf", crates.show_features_popup,desc = "Show features." },
				{"<localleader>cd", crates.show_dependencies_popup, desc ="Show dependencies." },
				{"<localleader>cu", crates.update_crate,desc = "Update crate." },
				{"<localleader>ca", crates.update_all_crates,desc = "Update all crates." },
				{"<localleader>cU", crates.upgrade_crate,desc = "Upgrade crate." },
				{"<localleader>cA", crates.upgrade_all_crates, desc ="Upgrade all crates." },
				{"<localleader>cH", crates.open_homepage, desc ="Open homepage." },
				{"<localleader>cR", crates.open_repository, desc ="Open repository." },
				{"<localleader>cD", crates.open_documentation,desc = "Open documentation." },
				{"<localleader>cC", crates.open_crates_io,desc = "Open crates io." },
			})
		end,
	})
end

return M
