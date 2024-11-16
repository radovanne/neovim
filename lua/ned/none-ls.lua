local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	-- local diagnostics =  null_ls.builtins.diagnostics

	local sources = {
		formatting.stylua,
		formatting.prettier,
		formatting.black,
		formatting.ocamlformat.with({
			extra_args = { "--if-then-else", "vertical" },
		}),
		-- No need to use custom formatting for now..
		-- formatting.zprint.with({
		-- 	filetypes = { "clojure", "edn" },
		-- 	command = "zprintm",
		-- }),
		null_ls.builtins.completion.spell,
	}

	local function on_attach(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd([[
			augroup LspFormatting
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
			augroup END
			]])
		end
	end

	null_ls.setup({
		debug = true,
		sources = sources,
		on_attach = on_attach,
	})

	-- null_ls.setup({
	-- 	sources = {
	-- 		formatting.stylua,
	-- 		formatting.prettier,
	-- 		formatting.black,
	-- 		formatting.ocamlformat,
	-- 		-- No need to use custom formatting for now..
	-- 		-- formatting.zprint.with({
	-- 		-- 	filetypes = { "clojure", "edn" },
	-- 		-- 	command = "zprintm",
	-- 		-- }),
	-- 		null_ls.builtins.completion.spell,
	-- 	},
	-- })
end

return M
