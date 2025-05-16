local M = {}

local function lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gR", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gD", "<cmd>Telescope lsp_references<CR>", opts)
	keymap(bufnr, "n", "cx", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
end

M.on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
	if client.supports_method("textDocument/inlayHint") then
		vim.lsp.inlay_hint.enable(true)
	end
end

M.common_capabilities = function()
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	return capabilities
end

M.config = function()
	local wk = require("which-key")
	wk.add({
		{ "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action" },
		{
			"<leader>cf",
			"<cmd>lua vim.lsp.buf.format({async = true})<cr>",
			desc = "Format",
		},
		{ "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
		{ "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Next Diagnostic" },
		{ "<leader>lh", "<cmd>lua require('plugins.lspconfig').toggle_inlay_hints()<cr>", desc = "Hints" },
		{ "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Prev Diagnostic" },
		{ "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
		{ "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
		{ "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename" },
	})

	local lspconfig = require("lspconfig")
	local icons = require("config.icons")

	local servers = {
		"html",
		"cssls",
		"ts_ls",
		"emmet_ls",
		"dockerls",
		"bashls",
		"jsonls",
		"yamlls",
		"solargraph",
		"clangd",
		"ols",
		"pyright",
		"ocamllsp",
		"clojure_lsp",
		"gopls",
		"lua_ls",
		"intelephense",
		"jdtls"
	}

	local default_diagnostic_config = {
		signs = {
			active = true,
			values = {
				{ name = "DiagnosticSignError", text = icons.diagnostics.Error },
				{ name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
				{ name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
				{ name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
			},
		},
		virtual_text = false,
		update_in_insert = false,
		underline = true,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
			max_width = 80,
		},
	}

	vim.diagnostic.config(default_diagnostic_config)

	local handlers_style_table = { style = "minimal", max_width = 80 }

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, handlers_style_table)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, handlers_style_table)

	for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config() or {}, "signs", "values") or {}) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
	end

	for _, server in pairs(servers) do
		local opts = {
			on_attach = M.on_attach,
			capabilities = M.common_capabilities(),
		}

		local require_ok, settings = pcall(require, "ned.lspsettings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", settings, opts)
		end

		if server == "intelephense" then
			lspconfig[server].setup({
				root_dir = require("lspconfig.util").root_pattern("composer.json", ".git", "package.json"),
				on_attach = M.on_attach,
				capabilities = M.common_capabilities,
			})
		end

		if server == "jdtls" then
		require("config.jdtls").setup_jdtls()
		end

		if server == "ruby_lsp" then
			lspconfig[server].setup({
				init_options = {
					enabledFeatures = {
						codeActions = true,
						codeLens = true,
						completion = true,
						definition = true,
						diagnostics = true,
						documentHighlights = true,
						documentLink = true,
						documentSymbols = true,
						foldingRanges = true,
						formatting = true,
						hover = true,
						inlayHint = true,
						onTypeFormatting = true,
						selectionRanges = true,
						semanticHighlighting = true,
						signatureHelp = true,
						typeHierarchy = true,
						workspaceSymbol = true,
					},
					featuresConfiguration = {
						inlayHint = {
							implicitHashValue = true,
							implicitRescue = true,
						},
					},
					formatter = "auto",
					-- linters = { "standard", "rubocop" },
					linters = { "rubocop" },
				},
				on_attach = M.on_attach,
				capabilities = M.common_capabilities,
			})
		end

		if server == "solargraph" then
			lspconfig[server].setup({
				filetypes = { "ruby", "rakefile" },
				root_dir = lspconfig.util.root_pattern("Gemfile", ".git", "."),
				settings = {
					solargraph = {
						autoformat = true,
						completion = true,
						hover = true,
						formatting = true,
						diagnostic = true,
						folding = true,
						references = true,
						rename = true,
						symbols = true,
					},
					on_attach = M.on_attach,
					capabilities = M.common_capabilities,
				},
			})
		end

		lspconfig[server].setup(opts)
	end
end

return M
