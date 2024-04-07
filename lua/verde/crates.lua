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

			wk.register({
				c = {
					name = "Crates",
					t = { crates.toggle, "Toggle crates." },
					r = { crates.reload, "Reload crates." },
					v = { crates.show_versions_popup, "Show versions." },
					f = { crates.show_features_popup, "Show features." },
					d = { crates.show_dependencies_popup, "Show dependencies." },
					u = { crates.update_crate, "Update crate." },
					a = { crates.update_all_crates, "Update all crates." },
					U = { crates.upgrade_crate, "Upgrade crate." },
					A = { crates.upgrade_all_crates, "Upgrade all crates." },
					H = { crates.open_homepage, "Open homepage." },
					R = { crates.open_repository, "Open repository." },
					D = { crates.open_documentation, "Open documentation." },
					C = { crates.open_crates_io, "Open crates io." },
				},
			}, {
				mode = "n",
				prefix = "<localleader>",
			})
		end,
	})
end

return M
