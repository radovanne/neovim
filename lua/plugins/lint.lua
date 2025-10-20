vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-lint" }
})

local ok, lint = pcall(require, "lint")
-- NOTE: This does not work I guess
if ok then
	lint.linters_by_ft = {
		elixir = { "credo" }
	}

	lint.linters.credo = {
		name = "credo",
		cmd = "mix",
		stdin = false,
		args = { "credo", "--format", "flycheck", "--read-from-stdin", "--strict" },
		stream = "stdout",
		ignore_exitcode = true,
		parser = require("lint.parser").from_errorformat("%f:%l:%c: %t: %m", {
			source = "credo",
			severity_map = {
				R = vim.diagnostic.severity.HINT, -- Refactor
				D = vim.diagnostic.severity.INFO, -- Design
				W = vim.diagnostic.severity.WARN, -- Warning
				F = vim.diagnostic.severity.ERROR, -- Failure
			},
		}),
	}
	local lint_augroup = vim.api.nvim_create_augroup("LintCredo", { clear = true })
	vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			require("lint").try_lint()
		end,
	})
end
